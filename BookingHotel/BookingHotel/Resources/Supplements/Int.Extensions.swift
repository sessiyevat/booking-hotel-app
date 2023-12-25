//
//  Int.Extensions.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import Foundation

extension Int {
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        if let formattedBalance = formatter.string(from: NSNumber(value: self)) {
            return formattedBalance
        } else {
            return "\(self)"
        }
    }
    
    func getOrdinalString() -> String {
        switch self {
            case 1:
                return "Первый"
            case 2:
                return "Второй"
            case 3:
                return "Третий"
            case 4:
                return "Чертвертый"
            case 5:
                return "Пятый"
            default:
                return .empty
        }
    }
}
