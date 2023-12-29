//
//  ExpandableView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/23/23.
//

import SwiftUI
import Combine

struct TouristsListView: View {
    
    // MARK:  - Properties
    
    @Binding var tourists: [Tourist]
    @Binding var isValidInfo: Bool
    
    // MARK:  - Body
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(tourists) { tourist in
                TouristDetailView(
                    tourist: self.$tourists[self.touristIndex(for: tourist)],
                    isValidInfo: $isValidInfo
                )
                .animation(.linear(duration: 0.3))
            }
        }
    }
    
    // MARK:  - Private Methods
    
    private func touristIndex(for tourist: Tourist) -> Int {
       return tourists.firstIndex(where: { $0.id == tourist.id }) ?? 0
    }
}
