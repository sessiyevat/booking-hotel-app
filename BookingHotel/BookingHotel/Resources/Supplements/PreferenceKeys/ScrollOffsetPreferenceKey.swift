//
//  ScrollOffsetPreferenceKey.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/29/23.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
