//
//  TouristDetailView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct TouristDetailView: View {
    
    // MARK: - Properties
    
    @Binding var tourist: Tourist
    @Binding var isValidInfo: Bool
    @State private var isExpanded: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            content
        }
        .sectionCustomStyle(padding: .zero, cornerRadius: Constants.Layout.cornerRadius)
        .onChange(of: isValidInfo) { newValue in
            if newValue {
                withAnimation {
                    isExpanded = true
                }
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(tourist.id.getOrdinalString() + " " + Constants.Text.tourist)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .foregroundColor(Color.accentBlue)
                    .rotationEffect(.degrees(isExpanded ? Constants.Layout.rotationDegree : .zero))
                    .frame(width: Constants.Layout.iconSize, height: Constants.Layout.iconSize)
                    .background(Color.accentBlue.opacity(0.1))
                    .cornerRadius(Constants.Layout.iconCornerRadius)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading) {
                    InputField(type: .default, placeHolderText: Constants.Text.name, text: $tourist.name, isValid: $isValidInfo)
                    InputField(type: .default, placeHolderText: Constants.Text.surname, text: $tourist.surname, isValid: $isValidInfo)
                    InputField(type: .date(pattern: Constants.Text.datePattern, type: .birthDate), placeHolderText: Constants.Text.birthDate, text: $tourist.birthDate, isValid: $isValidInfo)
                    InputField(type: .default, placeHolderText: Constants.Text.citizenship, text: $tourist.citizenship, isValid: $isValidInfo)
                    InputField(type: .passportNo, placeHolderText: Constants.Text.passportNo, text: $tourist.passportNo, isValid: $isValidInfo)
                    InputField(type: .date(pattern: Constants.Text.datePattern, type: .passportValidationDate), placeHolderText: Constants.Text.passportExp, text: $tourist.validationDate, isValid: $isValidInfo)
                }
            }
        }
        .padding(Constants.Layout.padding)
        .frame(height: isExpanded ? nil : Constants.Layout.collapsedHeight)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Constants

extension TouristDetailView {
    private enum Constants {
        enum Layout {
            static let cornerRadius: CGFloat = 12
            static let rotationDegree: CGFloat = 180
            static let iconSize: CGFloat = 32
            static let iconCornerRadius: CGFloat = 6
            static let padding: CGFloat = 16
            static let collapsedHeight: CGFloat = 58
        }
        
        enum Text {
            static let name: String = "Имя"
            static let surname: String = "Фамилия"
            static let birthDate: String = "Дата рождения"
            static let citizenship: String =  "Гражданство"
            static let passportNo: String = "Номер загранпаспорта"
            static let passportExp: String = "Срок действия загранпаспорта"
            static let tourist: String = "турист"
            static let datePattern: String = "__.__.____"
        }
    }
}
