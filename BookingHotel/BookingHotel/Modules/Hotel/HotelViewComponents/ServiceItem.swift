//
//  ServiceItem.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//

import SwiftUI

struct ServiceItem: View {
    
    public struct Attribute {
        let titleColor: Color
        let subtitleColor: Color
        let leftIconSize: CGSize
        let leftIconColor: Color
        let rightIconSize: CGSize
        let rightIconColor: Color
        
        init(
            titleColor: Color = .textColor,
            subtitleColor: Color = .textPrimaryGray,
            leftIconSize: CGSize = CGSize(width: 24, height: 24),
            leftIconColor: Color = .black,
            rightIconSize: CGSize = CGSize(width: 24, height: 24),
            rightIconColor: Color = .textColor
        ) {
            self.titleColor = titleColor
            self.subtitleColor = subtitleColor
            self.leftIconSize = leftIconSize
            self.leftIconColor = leftIconColor
            self.rightIconSize = rightIconSize
            self.rightIconColor = rightIconColor
        }
    }
    
    var icon: Image
    var title: String
    var subtitle: String
    var attribute: Attribute
    
    var body: some View {
        VStack(spacing: .zero) {
            Button(action: {}) {
                HStack {
                    icon
                        .renderingMode(.template)
                        .foregroundColor(attribute.leftIconColor)
                        .frame(width: attribute.leftIconSize.width, height: attribute.leftIconSize.height)
                    
                    VStack(alignment: .leading, spacing: Constants.spacing) {
                        Text(title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(attribute.titleColor)
                        Text(subtitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(attribute.subtitleColor)
                    }
                    .padding(.leading, Constants.leftPadding)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundColor(attribute.rightIconColor)
                        .frame(width: attribute.rightIconSize.width, height: attribute.rightIconSize.width)
                }
            }
        }
    }
}

extension ServiceItem {
    private enum Constants {
        static let spacing: CGFloat = 2
        static let leftPadding: CGFloat = 12
    }
}
