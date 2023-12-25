//
//  ChipsView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/20/23.
//


import SwiftUI

struct ChipsView: View {
    
    var items: [String]
    @State var totalHeight: CGFloat = .zero
    
    var body: some View {
        
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(items, id: \.self) { chipsData in
                    ChipView(
                        title: chipsData,
                        tintColor: .textPrimaryGray,
                        backgroundColor: .secondaryBackground
                    )
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height + 8
                            }
                            
                            let result = width
                            if chipsData == items.last! {
                                width = 0
                            } else {
                                width -= dimension.width + 8
                            }
                            return result
                          }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if chipsData == items.last! {
                                height = 0
                            }
                            return result
                        }
                }
            }
            .background(
                GeometryReader { chipGeo in
                    Color.clear
                        .preference(key: TotalHeightKey.self, value: chipGeo.size.height)
                }
            )
        }
        .onPreferenceChange(TotalHeightKey.self) { height in
            totalHeight = height
        }
        .frame(height: totalHeight)
    }
}
