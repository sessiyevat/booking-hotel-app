//
//  ChipView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct ChipView: View {
    
    // MARK: - Properties
    
    let title: String
    let tintColor: Color
    let backgroundColor: Color
    let rightIcon: Image?
    let action: () -> Void
    
    init(
        title: String,
        tintColor: Color,
        backgroundColor: Color,
        rightIcon: Image? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.rightIcon = rightIcon
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .lineLimit(1)
                .foregroundColor(tintColor)
            
            rightIcon?
                .renderingMode(.template)
                .foregroundColor(tintColor)
        }
        .padding(.vertical, Constants.verticalPadding)
        .padding(.horizontal, Constants.horizontalPadding)
        .background(backgroundColor)
        .cornerRadius(Constants.cornerRadius)
        .onTapGesture(perform: action)
    }
}

// MARK: - Constants

extension ChipView {
    private enum Constants {
        static let verticalPadding: CGFloat = 5
        static let horizontalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 5
        static let spacing: CGFloat = 2
    }
}
