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
    @State var imageUrls: [String]
    
    private var height: CGFloat
    
    init(imageUrls: [String], height: CGFloat) {
        self.imageUrls = imageUrls
        self.height = height
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            CarouselView(items: imageUrls, index: $currentIndex, content: { imageUrl in
                GeometryReader { proxy in
                    
                    let size = proxy.size

                    ImageView(
                        url: URL(string: imageUrl),
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
                CarouselIndicator(count: imageUrls.count, currentIndex: $currentIndex),
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
