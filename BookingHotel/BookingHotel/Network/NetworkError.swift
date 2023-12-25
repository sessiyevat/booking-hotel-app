//
//  NetworkError.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/19/23.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidData

    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL. Please check the URL and try again."
        case .invalidData:
            return "Invalid or unavailable network data. Please try again later."
        }
    }
}
