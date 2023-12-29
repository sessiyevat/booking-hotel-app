//
//  SuccessPaymentView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/23/23.
//

import SwiftUI

struct SuccessPaymentView: View {
    
    @EnvironmentObject private var coordinator: AppCoordinator<MainNavigationRouter>
    @ObservedObject private var viewModel: SuccessPaymentViewModel = SuccessPaymentViewModel()

    var body: some View {
        CustomNavigationView {
            VStack(spacing: .zero) {
                
                Spacer()
                
                VStack(spacing: .zero) {
                    ZStack {
                        Circle()
                            .frame(width: Constants.Layout.circleSize, height: Constants.Layout.circleSize)
                            .foregroundColor(.backgroundMain)
                        Text("🎉")
                            .font(.system(size: Constants.Layout.iconSize))
                    }
                    
                    Text(Constants.Text.subtitle)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, Constants.Layout.subtitlePadding)
                    
                    Text(String(format: Constants.Text.description, viewModel.generateOrderNo()))
                        .font(.system(size: 16))
                        .foregroundColor(.textPrimaryGray)
                        .multilineTextAlignment(.center)
                        .padding(.top, Constants.Layout.descriptionTopPadding)
                }
                .padding(.horizontal, Constants.Layout.descriptionPadding)
                
                Spacer()
                
                VStack(spacing: .zero) {
                    Divider()
                        .background(Color.lineColor)
                    CustomButton(text: Constants.Text.buttonTitle, attribute: .init()) {
                        viewModel.goToRoot()
                    }
                    .padding(.horizontal, Constants.Layout.buttonPadding)
                    .padding(.vertical, Constants.Layout.buttonTopPadding)
                }
                .background(Color.white)
            }
            .onAppear {
                viewModel.coordinator = coordinator
            }
            .frame(height: calculateHeight())
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .customNavigationTitle(Constants.Text.title)
            .dragToDismiss()
        }
    }
    
    private func calculateHeight() -> CGFloat {
        let topSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let navigationBarHeight: CGFloat = Constants.Layout.fixedNavBarHeight
        let totalHeight = UIScreen.main.bounds.height - topSafeAreaHeight - bottomSafeAreaHeight - navigationBarHeight
        return totalHeight
    }
}

extension SuccessPaymentView {
    private enum Constants {
        enum Layout {
            static let circleSize: CGFloat = 94
            static let iconSize: CGFloat = 44
            static let subtitlePadding: CGFloat = 32
            static let descriptionTopPadding: CGFloat = 20
            static let descriptionPadding: CGFloat = 23
            static let buttonPadding: CGFloat = 16
            static let buttonTopPadding: CGFloat = 12
            static let fixedNavBarHeight: CGFloat = 57
        }
        
        enum Text {
            static let title: String = "Заказ оплачен"
            static let subtitle: String = "Ваш заказ принят в работу"
            static let description: String = "Подтверждение заказа №%d может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
            static let buttonTitle: String = "Супер!"
        }
    }
}

