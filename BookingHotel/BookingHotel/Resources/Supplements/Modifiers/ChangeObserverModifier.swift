//
//  ChangeObserverModifier.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI
import Combine

public struct ChangeObserverModifier<V: Equatable>: ViewModifier {
    public init(newValue: V, action: @escaping (V) -> Void) {
        self.newValue = newValue
        self.newAction = action
    }

    private typealias Action = (V) -> Void

    private let newValue: V
    private let newAction: Action

    @State private var state: (V, Action)?

    public func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            assertionFailure("Please don't use this ViewModifer directly and use the `onChange(of:perform:)` modifier instead.")
        }
        return content
            .onAppear()
            .onReceive(Just(newValue)) { newValue in
                if let (currentValue, action) = state, newValue != currentValue {
                    action(newValue)
                }
                state = (newValue, newAction)
            }
    }
}
