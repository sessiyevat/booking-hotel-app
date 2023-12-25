//
//  HotelModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/19/23.
//

import Foundation

public struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let image_urls: [String]
    let about_the_hotel: HotelInfo
    
    init(
        id: Int = .zero,
        name: String = .empty,
        adress: String = .empty,
        minimalPrice: Int = .zero,
        priceFor: String = .empty,
        rating: Int = .zero,
        imageUrls: [String] = [],
        aboutHotel: HotelInfo = HotelInfo()
    ) {
        self.id = id
        self.name = name
        self.adress = adress
        self.minimal_price = minimalPrice
        self.price_for_it = priceFor
        self.rating = rating
        self.image_urls = imageUrls
        self.about_the_hotel = aboutHotel
    }
}

struct HotelInfo: Codable {
    let description: String
    let peculiarities: [String]
    
    init(description: String = String(), peculiarities: [String] = []) {
        self.description = description
        self.peculiarities = peculiarities
    }
}
