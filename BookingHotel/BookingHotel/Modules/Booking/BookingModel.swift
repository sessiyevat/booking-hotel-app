//
//  BookingModel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import Foundation

struct Tourist: Identifiable, Hashable {
    let id: Int
    var name: String
    var surname: String
    var birthDate: String
    var citizenship: String
    var passportNo: String
    var validationDate: String
    
    init(
        id: Int,
        name: String = .empty,
        surname: String = .empty,
        birthDate: String = .empty,
        citizenship: String = .empty,
        passportNo: String = .empty,
        validationDate: String = .empty
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.citizenship = citizenship
        self.passportNo = passportNo
        self.validationDate = validationDate
    }
}
