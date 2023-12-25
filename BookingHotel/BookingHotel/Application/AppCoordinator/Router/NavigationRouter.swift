//
//  NavigationRouter.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/22/23.
//

import SwiftUI

public protocol NavigationRouter {
    
    associatedtype V: View
    var transition: NavigationTransitionStyle { get }

    @ViewBuilder
    func view() -> V
}
