//
//  NetworkService.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/19/23.
//

import Foundation
import Combine

final class NetworkService {
    
    static let shared = NetworkService()
    
    private func createRequest(for apiKey: String) -> URLRequest? {
        guard let url = URL(string: "\(Constants.baseURL)\(apiKey)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Constants.contentType, forHTTPHeaderField: Constants.contentHeaderField)
        return request
    }
    
    private func executeRequest<T: Codable>(apiKey: String) -> AnyPublisher<T, Error> {
        guard let request = createRequest(for: apiKey) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getHotelData() -> AnyPublisher<Hotel, Error> {
        return executeRequest(apiKey: Constants.hotelAPIKey)
    }

    func getRoomsData() -> AnyPublisher<Rooms, Error> {
        return executeRequest(apiKey: Constants.roomsAPIKey)
    }
}

extension NetworkService {
    enum Constants {
        static let baseURL = "https://run.mocky.io/v3/"
        static let hotelAPIKey = "d144777c-a67f-4e35-867a-cacc3b827473"
        static let roomsAPIKey = "8b532701-709e-4194-a41c-1a903af00195"
        static let contentType = "application/json; charset=utf-8"
        static let contentHeaderField = "Content-Type"
    }
}
