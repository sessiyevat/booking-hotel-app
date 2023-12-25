//
//  HotelView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/19/23.
//

import SwiftUI

struct HotelView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var coordinator: AppCoordinator<MainRouter>
    @ObservedObject private var viewModel: HotelViewModel = HotelViewModel()
    
    // MARK: - Body
    
    var body: some View {
        if viewModel.isLoading {
            ActivityIndicator(isAnimating: viewModel.isLoading)
        } else {
            content
        }
    }
    
    // MARK: - View Components
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Constants.Layout.stackSpacing) {
                hotelBasicInfo
                    .sectionCustomStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(Constants.Layout.cornerRadius, corners: [.bottomLeft, .bottomRight])

                additionalInfo
                    .sectionCustomStyle()
                    .cornerRadius(Constants.Layout.cornerRadius)
                
                VStack(spacing: .zero) {
                    Divider()
                        .background(Color.lineColor)
                    CustomButton(text: Constants.Text.buttonTitle, attribute: .init()) {
                        viewModel.navigateToHotelRooms()
                    }
                    .padding(.horizontal, Constants.Layout.defaultPadding)
                    .padding(.vertical, Constants.Layout.descriptionTopPadding)
                }
                .background(Color.white)
            }
            .onAppear {
                viewModel.coordinator = coordinator
                configureNavigationBar()
            }
        }
        .background(Color.backgroundMain)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarTitle(Constants.Text.title)
    }
    
    private var hotelBasicInfo: some View {
        VStack(alignment: .leading, spacing: Constants.Layout.infoStackSpacing) {
            
            if !viewModel.hotel.image_urls.isEmpty {
                ImageCarouselView(
                    images: viewModel.hotel.image_urls,
                    height: Constants.Layout.carouselHeight
                )
            }
            
            VStack(alignment: .leading, spacing: Constants.Layout.stackSpacing) {
                RatingView(
                    rating: viewModel.hotel.rating,
                    ratingStatus: viewModel.getRatingStatus()
                )
                
                Text(viewModel.hotel.name)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)
                
                Button(action: {}) {
                    Text(viewModel.hotel.adress)
                        .foregroundColor(.accentBlue)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                }
            }

            HStack(alignment: .bottom, spacing: .zero) {
                Text("от \(viewModel.hotel.minimal_price.formattedString()) ₽")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.black)

                Text(viewModel.hotel.price_for_it)
                    .font(.system(size: 16))
                    .foregroundColor(.textPrimaryGray)
                    .padding(.leading, Constants.Layout.leadingPadding)
            }
        }
    }
    
    private var additionalInfo: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.Text.infoTitle)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.black)

            ChipsView(items: viewModel.hotel.about_the_hotel.peculiarities)
                .padding(.top, Constants.Layout.defaultPadding)
            
            Text(viewModel.hotel.about_the_hotel.description)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .lineLimit(nil)
                .padding(.top, Constants.Layout.descriptionTopPadding)
            
            VStack(spacing: .zero){
                ServiceItem(
                    icon: .happyEmoji,
                    title: Constants.Text.easeServices,
                    subtitle: Constants.Text.description,
                    attribute: .init()
                )
                
                divider
                
                ServiceItem(
                    icon: .checkSquare,
                    title: Constants.Text.includedServices,
                    subtitle: Constants.Text.description,
                    attribute: .init()
                )
                
                divider
                
                ServiceItem(
                    icon: .closeSquare,
                    title: Constants.Text.notIncludedServices,
                    subtitle: Constants.Text.description,
                    attribute: .init()
                )
            }
            .padding(Constants.Layout.servicesPadding)
            .background(Color.secondaryBackground)
            .cornerRadius(Constants.Layout.servicesCornerRadius)
            .padding(.top, Constants.Layout.defaultPadding)
        }
    }
    
    private var divider: some View {
        Divider()
            .background(Color.textPrimaryGray.opacity(0.15))
            .padding([.top, .bottom], Constants.Layout.dividerVerticalPadding)
            .padding(.leading, Constants.Layout.dividerLeftPadding)
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        coordinator.navigationController.navigationBar.standardAppearance = appearance
    }
}

// MARK: - Constants

extension HotelView {
    private enum Constants {
        enum Layout {
            static let stackSpacing: CGFloat = 8
            static let infoStackSpacing: CGFloat = 16
            static let cornerRadius: CGFloat = 12
            static let servicesCornerRadius: CGFloat = 15
            static let servicesPadding: CGFloat = 15
            static let leadingPadding: CGFloat = 8
            static let defaultPadding: CGFloat = 16
            static let descriptionTopPadding: CGFloat = 12
            static let dividerVerticalPadding: CGFloat = 10
            static let dividerLeftPadding: CGFloat = 40
            static let carouselHeight: CGFloat = 257
        }
        
        enum Text {
            static let title: String = "Отель"
            static let infoTitle: String = "Об отеле"
            static let easeServices: String = "Удобства"
            static let includedServices: String = "Что включено"
            static let notIncludedServices: String = "Что не включено"
            static let description: String = "Самое необходимое"
            static let buttonTitle: String = "К выбору номера"
        }
    }
}

