//
//  RatingView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/24/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    let ratingStatus: String
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Image.star
                .resizable()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
            Text("\(rating) " + ratingStatus)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.accentYellow)
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(Color.secondaryYellow)
        .cornerRadius(Constants.cornerRadius)
    }
}

// MARK: - Constants

extension RatingView {
    private enum Constants {
        static let spacing: CGFloat = 2
        static let iconSize: CGFloat = 15
        static let horizontalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 5
    }
}
