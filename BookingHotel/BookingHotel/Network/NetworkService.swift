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
    
    private func createRequest(for url: String, httpMethod: HTTPMethod = .GET) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue(Constants.contentType, forHTTPHeaderField: Constants.contentHeaderField)
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getHotelData() -> AnyPublisher<Hotel, Error> {
        guard let request = createRequest(for: "\(Constants.baseURL)\(Constants.hotelAPIKey)") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return executeRequest(request: request)
    }

    func getRoomsData() -> AnyPublisher<Rooms, Error> {
        guard let request = createRequest(for: "\(Constants.baseURL)\(Constants.roomsAPIKey)") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return executeRequest(request: request)
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
