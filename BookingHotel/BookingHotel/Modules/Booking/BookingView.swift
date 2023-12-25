//
//  BookingView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/21/23.
//

import SwiftUI

struct BookingView: View {
    
    // MARK: - Properties
        
    @EnvironmentObject private var coordinator: AppCoordinator<MainRouter>
    @ObservedObject var viewModel: BookingViewModel
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Constants.Layout.stackSpacing) {
                hotelBasicInfo
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .sectionCustomStyle(cornerRadius: Constants.Layout.cornerRadius)
                    .padding(.top, Constants.Layout.stackSpacing)
                
                bookingDetailsInfo
                    .sectionCustomStyle(cornerRadius: Constants.Layout.cornerRadius)
                
                clientInfo
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .sectionCustomStyle(cornerRadius: Constants.Layout.cornerRadius)
                
                touristsInfo
                
                paymentInfo
                    .sectionCustomStyle(cornerRadius: Constants.Layout.cornerRadius)
                
                VStack(spacing: .zero) {
                    Divider()
                        .background(Color.lineColor)
                    CustomButton(text: Constants.Text.pay, attribute: .init()) {
                        viewModel.checkForValidation()
                    }
                    .padding(.horizontal, Constants.Layout.defaultPadding)
                    .padding(.vertical, Constants.Layout.buttonTopPadding)
                }
                .background(Color.white)
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
        .background(Color.backgroundMain)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarTitle(Constants.Text.title)
        .navigationBarBackButtonTitleHidden()
    }
    
    // MARK: - View Components
    
    private var hotelBasicInfo: some View {
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
    }
    
    private var bookingDetailsInfo: some View {
        VStack(spacing: Constants.Layout.defaultPadding) {
            BookingDetailView(name: Constants.Text.flightFrom, description: Constants.MockText.cityFrom)
            BookingDetailView(name: Constants.Text.country, description: Constants.MockText.country)
            BookingDetailView(name: Constants.Text.dates, description: Constants.MockText.dates)
            BookingDetailView(name: Constants.Text.totalDays, description: Constants.MockText.days)
            BookingDetailView(name: Constants.Text.hotel, description: viewModel.hotel.name)
            BookingDetailView(name: Constants.Text.room, description: viewModel.selectedRoom.name)
            BookingDetailView(name: Constants.Text.food, description: Constants.MockText.foodService)
        }
    }
    
    private var clientInfo: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.Text.clientInfo)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.black)
            
            VStack(spacing: Constants.Layout.stackSpacing) {
                InputField(
                    type: .phoneNumber(phoneMask: Constants.Text.phoneMask),
                    placeHolderText: Constants.Text.phonePlaceholder,
                    text: $viewModel.phone,
                    isValid: $viewModel.isNotValidPhone
                )
                InputField(
                    type: .email,
                    placeHolderText: Constants.Text.emailPlaceholder,
                    text: $viewModel.email,
                    isValid: $viewModel.isNotValidEmail
                )
            }
            .padding(.top, Constants.Layout.clientInfoTopPadding)
            
            Text(Constants.Text.description)
                .font(.system(size: 14))
                .foregroundColor(.textPrimaryGray)
                .padding(.top, Constants.Layout.stackSpacing)
        }
    }
    
    private var touristsInfo: some View {
        VStack(spacing: Constants.Layout.stackSpacing) {
            TouristsListView(tourists: $viewModel.tourists, isValidInfo: $viewModel.isNotValidInfo)
            
            if viewModel.tourists.count < Constants.allowedTouristsCount {
                HStack {
                    Text(Constants.Text.addTourist)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .frame(width: Constants.Layout.iconSize, height: Constants.Layout.iconSize)
                        .background(Color.accentBlue)
                        .cornerRadius(Constants.Layout.iconCornerRadius)
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.addNewTourist()
                    }
                }
                .padding(Constants.Layout.defaultPadding)
                .frame(height: Constants.Layout.sectionHeight)
                .background(Color.white)
                .cornerRadius(Constants.Layout.cornerRadius)
            }
        }
    }
    
    private var paymentInfo: some View {
        VStack(spacing: Constants.Layout.defaultPadding) {
            PaymentDetailView(name: Constants.Text.tour, price: viewModel.totalCost)
            PaymentDetailView(name: Constants.Text.fuelFee, price: viewModel.fuelFee)
            PaymentDetailView(name: Constants.Text.serviceFee, price: viewModel.serviceFee)
            PaymentDetailView(name: Constants.Text.totalPay, price: viewModel.totalSum, isTotalPrice: true)
        }
    }
}

// MARK: - Constants

extension BookingView {
    private enum Constants {
        
        static let allowedTouristsCount: Int = 5
        
        enum Layout {
            static let stackSpacing: CGFloat = 8
            static let cornerRadius: CGFloat = 12
            static let defaultPadding: CGFloat = 16
            static let buttonTopPadding: CGFloat = 12
            static let clientInfoTopPadding: CGFloat = 20
            static let iconSize: CGFloat = 32
            static let iconCornerRadius: CGFloat = 6
            static let sectionHeight: CGFloat = 58
        }
        
        enum Text {
            static let title: String = "Бронирование"
            static let pay: String = "Оплатить"
            static let flightFrom: String = "Вылет из"
            static let country: String = "Страна, город"
            static let dates: String = "Даты"
            static let totalDays: String =  "Кол-во ночей"
            static let hotel: String = "Отель"
            static let room: String = "Номер"
            static let food: String = "Питание"
            static let clientInfo: String = "Информация о покупателе"
            static let phoneMask: String = "+7 (***) ***-**-**"
            static let phonePlaceholder: String = "Номер телефона"
            static let emailPlaceholder: String = "Почта"
            static let description: String = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту"
            static let addTourist: String = "Добавить туриста"
            static let tour: String = "Тур"
            static let fuelFee: String = "Топливный сбор"
            static let serviceFee: String = "Сервисный сбор"
            static let totalPay: String = "К оплате"
        }
        
        enum MockText {
            static let cityFrom: String = "Санкт-Петербург"
            static let country: String = "Египет, Хургада"
            static let dates: String = "19.09.2023 – 27.09.2023"
            static let days: String = "7 ночей"
            static let foodService: String =  "Все включено"
        }
    }
}
