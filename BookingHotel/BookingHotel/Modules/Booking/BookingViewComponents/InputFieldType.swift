//
//  InputFieldType.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/29/23.
//

import Foundation

public enum InputFieldType {
    case phoneNumber(phoneMask: String)
    case email
    case date(pattern: String, type: DateType)
    case passportNo
    case `default`
}

public enum DateType {
    case birthDate
    case passportValidationDate
}
