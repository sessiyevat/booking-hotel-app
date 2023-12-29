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
    
    // MARK: - Properties
    
    let type: InputFieldType
    let placeHolderText: String
    
    @Binding var text: String
    @Binding var isValid: Bool
    
    @State private var isEditing: Bool = false
    @State private var isInputValid: Bool = true
    @State var inputPattern: String = .empty

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
                        inputPattern = value.formatInput(inputPattern, "*")
                        text = inputPattern
                    })
                    .textFieldStyle()
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .keyboardType(.numberPad)
                    .onAppear {
                        isEditing = true
                        inputPattern = phoneMask
                    }
                    .onTapGesture {
                        text = inputPattern
                    }
                case .email:
                    TextField(String.empty, text: $text, onEditingChanged: { editing in
                        isEditing = editing
                        if !editing {
                            isInputValid = text.isValidEmail()
                        }
                    })
                    .textFieldStyle()
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                case .date(let pattern, let type):
                    TextField(String.empty, text: $text, onEditingChanged: { editing in
                        isEditing = editing
                        if !editing {
                            isInputValid = text.isValidDate(ofType: type)
                        }
                    })
                    .onChange(of: text, perform: { value in
                        inputPattern = value.formatInput(inputPattern, "_")
                        text = inputPattern
                    })
                    .textFieldStyle()
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .keyboardType(.numberPad)
                    .onAppear {
                        isEditing = true
                        inputPattern = pattern
                    }
                    .onTapGesture {
                        text = inputPattern
                    }
                default:
                    TextField(String.empty, text: $text, onEditingChanged: { editing in
                        isEditing = editing
                    })
                    .textFieldStyle()
                    .offset(y: text.isEmpty ? .zero : Constants.offset)
                    .keyboardType(.default)
            }
        }
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.padding)
        .background(isInvalid() ? Color.errorColor : Color.backgroundMain)
        .animation(.default)
        .cornerRadius(Constants.cornerRadius)
    }
    
    // MARK: - Private Methods
    
    private func isInvalid() -> Bool {
       switch type {
           case .phoneNumber:
               return (!isEditing && text.contains("*")) || (isValid && text.contains("*")) || (isValid && text.isEmpty)
           case .email:
               return isInputValid == false || (isValid && text.isEmpty)
           case .date:
               return isInputValid == false || (!isEditing && text.contains("_")) || (isValid && text.contains("_")) || (isValid && text.isEmpty)
           case .passportNo:
               return isValid && text.isEmpty || (isValid && !text.containsLettersAndDigits())
           case .default:
               return isValid && text.isEmpty || (isValid && !text.containsOnlyLetters())
       }
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
