//
//  BookingDetailView.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/21/23.
//

import SwiftUI

struct BookingDetailView: View {
    let name: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
                Text(name)
                    .font(.system(size: 16))
                    .foregroundColor(.textPrimaryGray)
                    .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
        }
        .lineLimit(nil)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
