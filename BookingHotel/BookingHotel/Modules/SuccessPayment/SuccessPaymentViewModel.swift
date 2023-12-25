//
//  SuccessPaymentViewModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/23/23.
//

import SwiftUI

final class SuccessPaymentViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator<MainRouter>?
    
    // MARK: - Public Methods
    
    func generateOrderNo() -> Int {
        return Int.random(in: 10000...100000)
    }
    
    func goToRoot() {
        coordinator?.popToRoot()
    }
}
