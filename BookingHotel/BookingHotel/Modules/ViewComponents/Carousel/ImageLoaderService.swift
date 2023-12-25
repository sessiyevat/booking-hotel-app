//
//  ImageLoaderService.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import Combine
import SwiftUI

final class ImageLoaderService: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    convenience init(url: URL?) {
        self.init()
        loadImage(for: url)
    }

    func loadImage(for url: URL?) {
        guard let url = url else { return }
        isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
               .map(\.data)
               .replaceError(with: Data())
               .receive(on: DispatchQueue.main)
               .sink { [weak self] data in
                   self?.isLoading = false
                   self?.image = UIImage(data: data)
               }
               .store(in: &cancellables)
    }
}
