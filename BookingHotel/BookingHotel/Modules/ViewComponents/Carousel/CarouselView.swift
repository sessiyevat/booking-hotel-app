//
//  Carousel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/24/23.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {
    
    // MARK: - Properties
    
    @Binding var index: Int
    @GestureState var offset: CGFloat = .zero
    @State var currentIndex: Int = .zero
    
    var content: (T) -> Content
    var items: [T]
    var spacing: CGFloat
    
    init(items: [T], index: Binding<Int>, spacing: CGFloat = 16, @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self.spacing = spacing
        self._index = index
        self.content = content
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width + spacing
            
            HStack(spacing: spacing) {
                ForEach(items, id: \.self) { item in
                    content(item)
                        .frame(width: proxy.size.width)
                }
            }
            .offset(x: (CGFloat(currentIndex) * -width) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { gestureValue, offset, _ in
                        offset = gestureValue.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundedIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundedIndex), items.count - 1), 0)
                        index = currentIndex
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundedIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundedIndex), items.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}
