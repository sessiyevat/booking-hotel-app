//
//  BookingViewModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/21/23.
//

import SwiftUI
import Combine

final class BookingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private (set) var hotel: Hotel
    @Published private (set) var selectedRoom: Room
    @Published var tourists: [Tourist] = [Tourist(id: 1)]
    
    @Published var phone: String = .empty
    @Published var email: String = .empty
    @Published var isNotValidPhone: Bool = false
    @Published var isNotValidEmail: Bool = false
    @Published var isNotValidInfo = false
    
    var coordinator: AppCoordinator<MainNavigationRouter>?
    
    // MARK: - Computed Properties
       
    var totalCost: Int {
        return tourists.count * selectedRoom.price
    }

    var fuelFee: Int {
        return Int(Double(totalCost) * 0.05)
    }

    var serviceFee: Int {
        return Int(Double(totalCost) * 0.01)
    }

    var totalSum: Int {
        return totalCost + fuelFee + serviceFee
    }

    private var isValidPhone: Bool {
        return !phone.isEmpty && !phone.contains("*")
    }

    private var isValidEmail: Bool {
        return !email.isEmpty && email.isValidEmail()
    }

    private var isValidTouristsInfo: Bool {
        return tourists.allSatisfy { tourist in
           tourist.name.containsOnlyLetters() &&
           tourist.surname.containsOnlyLetters() &&
           tourist.citizenship.containsOnlyLetters() &&
           tourist.birthDate.isValidDate(ofType: .birthDate) &&
           tourist.passportNo.containsLettersAndDigits() &&
           tourist.validationDate.isValidDate(ofType: .passportValidationDate)
        }
    }
        
    // MARK: - Initializer
    
    init(hotel: Hotel, selectedRoom: Room) {
        self.hotel = hotel
        self.selectedRoom = selectedRoom
    }
    
    // MARK: - Public Methods
    
    func addNewTourist() {
        let newTourist = Tourist(id: tourists.count + 1)
        tourists.append(newTourist)
    }
    
    func checkForValidation() {
        isNotValidPhone = !isValidPhone
        isNotValidEmail = !isValidEmail
        isNotValidInfo = !isValidTouristsInfo
        
        if !isNotValidPhone && !isNotValidEmail && !isNotValidInfo {
            navigateToSuccessPayment()
        }
    }
    
    func navigateToSuccessPayment() {
        coordinator?.push(.successfulPayment)
    }
    
    func getRatingStatus() -> String {
        switch hotel.rating {
            case 4...5:
                return "Превосходно"
            default:
                return .empty
        }
    }
}
