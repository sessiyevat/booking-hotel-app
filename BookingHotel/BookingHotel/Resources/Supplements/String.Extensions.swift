//
//  String.Extensions.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import Foundation

public extension String {
    
    static let empty: String = String()
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
