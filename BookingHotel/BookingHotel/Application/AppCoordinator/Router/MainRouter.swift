//
//  MainRouter.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/22/23.
//

import SwiftUI

public enum MainRouter: NavigationRouter {
    case hotel
    case rooms(Hotel)
    case booking(Hotel, Room)
    case successfulPayment
    
    public var transition: NavigationTransitionStyle {
        return .push
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
            case .hotel:
                HotelView()
            case .rooms(let hotel):
                RoomsView(viewModel: RoomsViewModel(hotel: hotel))
            case .booking(let hotel, let room):
                BookingView(viewModel: BookingViewModel(hotel: hotel, selectedRoom: room))
            case .successfulPayment:
                SuccessPaymentView()
        }
    }
}
