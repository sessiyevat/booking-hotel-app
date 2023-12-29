//
//  CustomNavigationBarContainerView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/29/23.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    
    let content: Content
    @State private var hideBackButton: Bool = false
    @State private var title: String = .empty
    @State private var scrollOffset: CGFloat = .zero
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            CustomNavigationBarView(
                hideBackButton: hideBackButton,
                title: title,
                scrollOffset: $scrollOffset
            )
            ScrollView(showsIndicators: false) {
                content
                    .background(
                        GeometryReader {
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y
                                )
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                        self.scrollOffset = offset
                    }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .coordinateSpace(name: "scroll")
        }
        .navigationBarHidden(true)
        .onPreferenceChange(CustomNavigationBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavigationBackButtonPreferenceKey.self, perform: { value in
            self.hideBackButton = value
        })
    }
}
