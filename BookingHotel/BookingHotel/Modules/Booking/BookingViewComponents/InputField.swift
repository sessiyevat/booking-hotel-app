//
//  InputField.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/21/23.
//

import Foundation
import Combine
import SwiftUI

struct InputField: View {
    
    public enum InputFieldType {
        case phoneNumber(phoneMask: String)
        case email
        case `default`
    }
    
    // MARK: - Properties
    
    let type: InputFieldType
    let placeHolderText: String
    
    @Binding var text: String
    @Binding var isValid: Bool
    
    @State private var isEditing: Bool = false
    @State private var isEmailValid: Bool = true
    @State var formattedNumber: String = .empty

    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeHolderText)
                .foregroundColor(.placeholderColor)
                .font(.system(size: text.isEmpty ? 17 : 12))
                .offset(y: text.isEmpty ? .zero : -Constants.offset)
                .frame(maxWidth: .infinity, alignment: .leading)
        
            switch type {
                case .phoneNumber(let phoneMask):
                    TextField(String.empty, text: $text, onEditingChanged: { editing in
                        isEditing = editing
                    })
                    .onChange(of: text, perform: { value in
                        self.change(value)
                    })
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .keyboardType(.numbersAndPunctuation)
                    .onAppear {
                        formattedNumber = phoneMask
                    }
                    .onTapGesture {
                        text = formattedNumber
                    }
                case .email:
                    TextField(String.empty, text: $text, onEditingChanged: { editing in
                        isEditing = editing
                        if !editing {
                            isEmailValid = text.validateEmail()
                        }
                    })
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                case .default:
                    TextField(String.empty, text: $text)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .offset(y: text.isEmpty ? .zero : Constants.offset)
                        .keyboardType(.default)
            }
        }
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.padding)
        .background(
            (isEmailValid == false || !isEditing && text.contains("*") || (isValid && text.isEmpty))
                ? Color.errorColor
                : Color.backgroundMain
        )
        .animation(.default)
        .cornerRadius(Constants.cornerRadius)
    }
    
    // MARK: - Private Methods
    
    private func change(_ newValue: String) {
        if !newValue.isEmpty {
            formattedNumber = formatPhoneNumber(formattedNumber, newValue)
            text = formattedNumber
        }
    }
    
    private func formatPhoneNumber(_ formatted: String, _ number: String) -> String {
        var formattedString = formatted

        if number.count == formattedString.count {
            return number
        } else if number.count < formattedString.count && number.count > 1 {
            if let lastIndex = formattedString.indices.reversed().first(where: { formattedString[$0].isNumber }) {
                formattedString.replaceSubrange(lastIndex...lastIndex, with: "*")
                return formattedString
            }
        }

        if let asteriskIndex = formattedString.firstIndex(of: "*"), let lastDigit = number.last {
            formattedString.replaceSubrange(asteriskIndex...asteriskIndex, with: String(lastDigit))
        }

        return formattedString
    }
}

// MARK: - Constants

extension InputField {
    private enum Constants {
        static let offset: CGFloat = 8
        static let height: CGFloat = 52
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 17
    }
}
