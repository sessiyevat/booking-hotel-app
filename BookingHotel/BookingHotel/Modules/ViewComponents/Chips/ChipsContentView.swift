//
//  ChipsContentView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//


import SwiftUI

struct ChipsContentView: View {
    
    var items: [String]
    @State private var totalHeight: CGFloat = .zero
    
    var body: some View {
        
        var currentRowWidth: CGFloat = .zero
        var currentRowHeight: CGFloat = .zero
        
        return GeometryReader { parentGeometry in
            ZStack(alignment: .topLeading) {
                ForEach(items, id: \.self) { chipData in
                    ChipView(
                        title: chipData,
                        tintColor: .textPrimaryGray,
                        backgroundColor: .secondaryBackground
                    )
                    .alignmentGuide(.leading) { chipWidth in
                        if (abs(currentRowWidth - chipWidth.width) > parentGeometry.size.width) {
                            currentRowWidth = 0
                            currentRowHeight -= chipWidth.height + 8
                        }
                        let result = currentRowWidth
                        currentRowWidth = (chipData == items.last!) ? 0 : (currentRowWidth - chipWidth.width + 8)
                        return result
                    }
                    .alignmentGuide(.top) { chipHeight in
                        let result = currentRowHeight
                        currentRowHeight = (chipData == items.last!) ? 0 : currentRowHeight
                        return result
                    }
                }
            }
            .background(
                GeometryReader { chipGeometry in
                    Color.clear
                        .preference(key: TotalHeightPreferenceKey.self, value: chipGeometry.size.height)
                }
            )
        }
        .onPreferenceChange(TotalHeightPreferenceKey.self) { height in
            totalHeight = height
        }
        .frame(height: totalHeight)
    }
}
