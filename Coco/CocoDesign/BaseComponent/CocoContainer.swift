//
//  ViewContainer.swift
//  CocoDesign
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI

struct CocoContainer<Content: View>: View {
    private let width: CGFloat
    private let height: CGFloat
    private let backgroundColor: Color
    private let lineColor: Color
    private let cornerRadius: CGFloat
    private let borderColor: Color
    private let borderWidth: CGFloat
    private let content: Content
    
    init(
        width: CGFloat = 0,
        height: CGFloat = 0,
        backgroundColor: Color = .white,
        lineColor: Color = .clear ,
        cornerRadius: CGFloat = 8,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 1,
        @ViewBuilder content: () -> Content
    ) {
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.lineColor = lineColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

#Preview {
    CocoContainer() {
        CocoLabel("HelloWorld")
    }
}
