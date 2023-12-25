//
//  HotelViewModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/19/23.
//

import SwiftUI
import Combine

final class HotelViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var hotel: Hotel = Hotel()
    @Published var isLoading: Bool = true
    var coordinator: AppCoordinator<MainRouter>?
    
    private var cancellables: Set<AnyCancellable> = []
    private let networkService = NetworkService.shared
    
    // MARK: - Initializer
    
    init() {
        loadHotelData()
    }
    
    // MARK: - Public Methods
    
    private func loadHotelData() {
        networkService.getHotelData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] hotel in
                self?.hotel = hotel
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func getRatingStatus() -> String {
        switch hotel.rating {
            case 4...5:
                return "Превосходно"
            default:
                return .empty
        }
    }
    
    func navigateToHotelRooms() {
        coordinator?.push(.rooms(hotel))
    }
}

