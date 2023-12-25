//
//  View.Extensions.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/24/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func sectionCustomStyle(padding: CGFloat = 16, cornerRadius: CGFloat = 0) -> some View {
        self
            .padding(padding)
            .background(Color.white)
            .cornerRadius(cornerRadius)
    }
    
    func navigationBarBackButtonTitleHidden() -> some View {
      self.modifier(NavigationBarBackButtonTitleHiddenModifier())
    }
    
    @_disfavoredOverload
    @ViewBuilder public func onChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some View where V: Equatable {
        if #available(iOS 14, *) {
            onChange(of: value, perform: action)
        } else {
            modifier(ChangeObserver(newValue: value, action: action))
        }
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
