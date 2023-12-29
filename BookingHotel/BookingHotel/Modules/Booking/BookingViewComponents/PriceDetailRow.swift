//
//  PriceDetailRow.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct PriceDetailRow: View {
    let name: String
    let price: Int
    let isTotalPrice: Bool
    
    init(name: String, price: Int, isTotalPrice: Bool = false) {
        self.name = name
        self.price = price
        self.isTotalPrice = isTotalPrice
    }
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(.textPrimaryGray)
                .font(.system(size: 16))
            Spacer()
            Text("\(price.formattedString()) ₽")
                .font(.system(size: 16, weight: isTotalPrice ? .semibold : .regular))
                .foregroundColor(isTotalPrice ? .accentBlue : .black)
        }
    }
}
