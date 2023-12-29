//
//  CustomNavigationBarPreferenceKeys.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/29/23.
//

import SwiftUI

struct CustomNavigationBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = .empty
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavigationBackButtonPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
