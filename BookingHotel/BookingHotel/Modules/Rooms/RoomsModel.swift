//
//  RoomsModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//

import Foundation

public struct Rooms: Codable {
    let rooms: [Room]
    
    init(rooms: [Room] = []) {
        self.rooms = rooms
    }
}

public struct Room: Codable, Hashable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}
