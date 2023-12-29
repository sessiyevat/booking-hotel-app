//
//  RoomsView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//

import SwiftUI

struct RoomsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var coordinator: AppCoordinator<MainNavigationRouter>
    @ObservedObject var viewModel: RoomsViewModel
    
    // MARK: - Body

    var body: some View {
        if viewModel.isLoading {
            ActivityIndicator(isAnimating: viewModel.isLoading)
                .navigationBarHidden(true)
        } else {
            CustomNavigationView {
                VStack(spacing: .zero) {
                    ForEach(viewModel.hotelRooms.rooms, id: \.self) { room in
                        RoomCardView(room: room) {
                            viewModel.navigateToBooking(with: room)
                        }
                        .padding(.top, 8)
                    }
                }
                .onAppear {
                    viewModel.coordinator = coordinator
                }
                .background(Color.backgroundMain)
                .customNavigationTitle(viewModel.hotel.name)
                .dragToDismiss()
            }
        }
    }
}
