//
//  Carousel.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/24/23.
//

import SwiftUI

struct CarouselView<Content: View, T: Identifiable>: View {
    
    // MARK: - Properties
    
    @Binding var index: Int
    @GestureState var offset: CGFloat = .zero
    @State var currentIndex: Int = .zero
    
    var content: (T) -> Content
    var list: [T]
    var spacing: CGFloat
    
    init(items: [T], index: Binding<Int>, spacing: CGFloat = 16, @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self._index = index
        self.content = content
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width + spacing
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width)
                }
            }
            .offset(x: (CGFloat(currentIndex) * -width) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundedIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
                        currentIndex = index
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundedIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}
