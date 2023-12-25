//
//  ImageCarouselView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct ImageCarouselView: View {
    
    // MARK: - Properties
    
    @State var currentIndex: Int = .zero
    @State var images: [ImageInfo]
    
    private var height: CGFloat
    
    init(images: [String], height: CGFloat) {
        self.images = images.map { ImageInfo(imageUrl: $0) }
        self.height = height
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            CarouselView(items: images, index: $currentIndex, content: { image in
                GeometryReader { proxy in
                    
                    let size = proxy.size

                    ImageView(
                        url: URL(string: image.imageUrl),
                        placeholder: {
                            ZStack {
                                Image(systemName: "photo.on.rectangle")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.placeholderColor)
                                    .scaledToFit()
                                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                            }
                            .frame(width: size.width, height: height)
                            .background(Color.lineColor)
                            .cornerRadius(Constants.cornerRadius)
                        },
                        image: {
                                $0
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: height)
                                .cornerRadius(Constants.cornerRadius)
                        }
                      )
                }
            })
            .frame(height: height)
            
            .overlay(
                CarouselIndicator(count: images.count, currentIndex: $currentIndex),
                alignment: .bottom
            )
        }
    }
}

// MARK: - Constants

extension ImageCarouselView {
    private enum Constants {
        static let iconSize: CGFloat = 32
        static let cornerRadius: CGFloat = 15
    }
}
