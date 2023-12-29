//
//  CustomNavigationBarView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/29/23.
//

import SwiftUI

struct CustomNavigationBarView: View {
    
    @EnvironmentObject private var coordinator: AppCoordinator<MainNavigationRouter>
    
    let hideBackButton: Bool
    let title: String
    @Binding var scrollOffset: CGFloat
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                if !hideBackButton {
                    button
                }
                Spacer()
                titleSection
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Spacer()
                if !hideBackButton {
                    button
                        .opacity(.zero)
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .accentColor(.black)
            .foregroundColor(.black)
            .frame(height: Constants.height)
            .background(Color.white.edgesIgnoringSafeArea(.top))
        
            if scrollOffset > 0 {
                scrollEdge
            }
        }
    }
}

extension CustomNavigationBarView {
    
    private var button: some View {
        Button {
            coordinator.pop()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        Text(title)
            .font(.system(size: 18, weight: .medium))
    }
    
    private var scrollEdge: some View {
        Divider()
            .background(Color.shadowColor)
    }
}

extension CustomNavigationBarView {
    private enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let height: CGFloat = 57
    }
}
