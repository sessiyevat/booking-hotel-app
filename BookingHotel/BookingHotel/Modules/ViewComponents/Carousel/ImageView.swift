//
//  ImageView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct ImageView<Placeholder: View, ConfiguredImage: View>: View {
    
    var url: URL?
    private let placeholder: () -> Placeholder
    private let image: (Image) -> ConfiguredImage

    @ObservedObject var imageLoader: ImageLoaderService
    @State var imageData: UIImage?

    init(
        url: URL?,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder image: @escaping (Image) -> ConfiguredImage
    ) {
        self.url = url
        self.placeholder = placeholder
        self.image = image
        self.imageLoader = ImageLoaderService(url: url)
    }

    @ViewBuilder private var imageContent: some View {
        if let data = imageData {
            image(Image(uiImage: data))
        } else {
            placeholder()
        }
    }

    var body: some View {
        ZStack {
            imageContent
            
            if imageLoader.isLoading {
                ActivityIndicator(isAnimating: imageLoader.isLoading)
                    .frame(width: 32, height: 32)
                    .background(Color.lineColor)
            }
        }
        .onReceive(imageLoader.$image) { imageData in
            self.imageData = imageData
        }
    }
}
