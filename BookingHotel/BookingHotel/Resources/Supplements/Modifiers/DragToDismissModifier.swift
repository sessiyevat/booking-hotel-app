//
//  DragToDismissModifier.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/25/23.
//

import SwiftUI

struct DragToDismissModifier: ViewModifier {

    @Environment(\.presentationMode) var presentationMode

    @ViewBuilder @MainActor func body(content: Content) -> some View {
        content
          .contentShape(Rectangle())
          .gesture(
            DragGesture(coordinateSpace: .local)
              .onEnded { value in
                if value.translation.width > .zero
                    && value.translation.height > -30
                    && value.translation.height < 30 {
                    self.presentationMode.wrappedValue.dismiss()
                }
              }
          )
  }
}
