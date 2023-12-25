//
//  RoomsViewModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//

import Foundation
import Combine

final class RoomsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var hotelRooms: Rooms = Rooms()
    @Published var isLoading: Bool = false
    
    var hotel: Hotel
    var coordinator: AppCoordinator<MainRouter>?
    
    private var cancellables: Set<AnyCancellable> = []
    private let networkService = NetworkService.shared
    
    // MARK: - Initializer
    
    init(hotel: Hotel) {
        self.hotel = hotel
        loadRoomsData()
    }
    
    // MARK: - Methods
    
    private func loadRoomsData() {
        isLoading = true
        networkService.getRoomsData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] rooms in
                self?.hotelRooms = rooms
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func navigateToBooking(with selectedRoom: Room) {
        coordinator?.push(.booking(hotel, selectedRoom))
    }
}
