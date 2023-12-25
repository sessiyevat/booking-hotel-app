//
//  CustomButton.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/24/23.
//

import SwiftUI

struct CustomButton: View {
    
    struct Attribute {
        let backgroundColor: Color
        let tintColor: Color
        let height: CGFloat
        let cornerRadius: CGFloat
        
        init(
            backgroundColor: Color = .accentBlue,
            tintColor: Color = .white,
            height: CGFloat = 48,
            cornerRadius: CGFloat = 15
        ) {
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
            self.height = height
            self.cornerRadius = cornerRadius
        }
    }
    
    let text: String
    let attribute: Attribute
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
            .frame(height: attribute.height)
            .frame(maxWidth: .infinity)
            .background(attribute.backgroundColor)
            .foregroundColor(attribute.tintColor)
            .font(.headline)
            .cornerRadius(attribute.cornerRadius)
    }
}
