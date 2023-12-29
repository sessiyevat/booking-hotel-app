//
//  RoomCardView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct RoomCardView: View {
    var room: Room
    var action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Layout.defaultPadding) {
            VStack(alignment: .leading, spacing: Constants.Layout.stackSpacing) {
                
                ImageCarouselView(
                    imageUrls: room.image_urls,
                    height: Constants.Layout.carouselHeight
                )
                
                Text(room.name)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)
                
                ChipsContentView(items: room.peculiarities)
                
                ChipView(
                    title: Constants.Text.lastChipTitle,
                    tintColor: .accentBlue,
                    backgroundColor: .accentBlue.opacity(0.1),
                    rightIcon: Image(systemName: "chevron.right")
                )
            }
            
            HStack(alignment: .bottom, spacing: .zero) {
                Text("\(room.price.formattedString()) ₽")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.black)
                Text(room.price_per)
                    .font(.system(size: 16))
                    .foregroundColor(.textPrimaryGray)
                    .padding(.leading, Constants.Layout.stackSpacing)
            }
            
            CustomButton(
                text: Constants.Text.buttonTitle,
                attribute: .init(),
                action: action
            )
        }
        .padding(Constants.Layout.defaultPadding)
        .background(Color.white)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

extension RoomCardView {
    private enum Constants {
        enum Layout {
            static let stackSpacing: CGFloat = 8
            static let defaultPadding: CGFloat = 16
            static let cornerRadius: CGFloat = 12
            static let carouselHeight: CGFloat = 257
        }
        
        enum Text {
            static let lastChipTitle: String = "Подробнее о номере"
            static let buttonTitle: String = "Выбрать номер"
        }
    }
}
