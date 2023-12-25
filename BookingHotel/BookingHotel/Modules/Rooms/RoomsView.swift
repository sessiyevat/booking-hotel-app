//
//  RoomsView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//

import SwiftUI

struct RoomsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var coordinator: AppCoordinator<MainRouter>
    @ObservedObject var viewModel: RoomsViewModel
    
    // MARK: - Body

    var body: some View {
        if viewModel.isLoading {
            ActivityIndicator(isAnimating: viewModel.isLoading)
        } else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: .zero) {
                    ForEach(viewModel.hotelRooms.rooms, id: \.self) { room in
                        RoomCellView(room: room) {
                            viewModel.navigateToBooking(with: room)
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .onAppear {
                viewModel.coordinator = coordinator
            }
            .background(Color.backgroundMain)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonTitleHidden()
            .navigationBarTitle(viewModel.hotel.name)
        }
    }
}
