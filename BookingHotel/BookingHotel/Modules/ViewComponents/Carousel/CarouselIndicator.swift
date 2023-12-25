//
//  CarouselIndicator.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct CarouselIndicator: View {
    let count: Int
    @Binding var currentIndex: Int

    var body: some View {
        HStack(spacing: Constants.spacing) {
            ForEach(0..<count) { index in
                Circle()
                    .fill(Color.black.opacity(opacity(for: index)))
                    .frame(width: Constants.circleSize, height: Constants.circleSize)
                    .animation(.spring(), value: currentIndex == index)
            }
        }
        .padding(.vertical, Constants.verticalPadding)
        .padding(.horizontal, Constants.horizontalPadding)
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
        .padding(.bottom, Constants.bottomPadding)
    }
    
    private func opacity(for index: Int) -> Double {
        let distance = abs(currentIndex - index)
        let maxDistance = min(count - 1, 3)
        let baseOpacity = 0.22

        if index == currentIndex {
            return 1.0
        } else {
            return max(baseOpacity - Double(min(distance, maxDistance)) * 0.05, 0)
        }
    }
}

extension CarouselIndicator {
    private enum Constants {
        static let spacing: CGFloat = 5
        static let circleSize: CGFloat = 7
        static let verticalPadding: CGFloat = 5
        static let horizontalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 5
        static let bottomPadding: CGFloat = 8
    }
}
