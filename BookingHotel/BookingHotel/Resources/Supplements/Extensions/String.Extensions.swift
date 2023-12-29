//
//  String.Extensions.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import Foundation

public extension String {
    
    static let empty: String = String()
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidDate(format: String = "dd.MM.yyyy", ofType type: DateType) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: self) else {
            return false
        }

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        switch type {
            case .birthDate:
                return date < Date()
            case .passportValidationDate:
                return date > Date()
        }
    }
    
    func containsOnlyLetters() -> Bool {
        let letterCharacterSet = CharacterSet.letters
        let inputCharacterSet = CharacterSet(charactersIn: self)
        return inputCharacterSet.isSubset(of: letterCharacterSet)
    }
    
    func containsLettersAndDigits() -> Bool {
        let letterCharacterSet = CharacterSet.letters
        let digitCharacterSet = CharacterSet.decimalDigits

        let containsLetters = self.rangeOfCharacter(from: letterCharacterSet) != nil
        let containsDigits = self.rangeOfCharacter(from: digitCharacterSet) != nil
        return containsLetters && containsDigits && self.count >= 9
    }
    
    func formatInput(_ formattedString: String, _ placeholder: Character) -> String {
        var newFormattedString = formattedString

        if self.count == newFormattedString.count {
            return self
        } else if self.count < newFormattedString.count && self.count > 1 {
            if let lastIndex = newFormattedString.indices.reversed().first(where: { newFormattedString[$0].isNumber }) {
                newFormattedString.replaceSubrange(lastIndex...lastIndex, with: String(placeholder))
                return newFormattedString
            }
        }

        if let placeholderIndex = newFormattedString.firstIndex(of: placeholder), let lastDigit = self.last {
            newFormattedString.replaceSubrange(placeholderIndex...placeholderIndex, with: String(lastDigit))
        }

        return newFormattedString
    }
}
