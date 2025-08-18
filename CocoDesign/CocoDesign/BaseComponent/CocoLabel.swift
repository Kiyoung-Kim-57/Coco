//
//  BaseLabel.swift
//  CocoDesign
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI

public struct CocoLabel: View {
    private let text: String
    private let font: Font?
    private let textColor: Color
    private let backgroundColor: Color
    private let textPadding: CGFloat
    private let cornerRadius: CGFloat
    
    public init(
        _ text: String,
        font: Font? = nil,
        textColor: Color = .black,
        backgroundColor: Color = .clear,
        textPadding: CGFloat = 10,
        cornerRadius: CGFloat = 0
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textPadding = textPadding
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        Text(text)
            .font(font ?? .body)
            .padding(textPadding)
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    CocoLabel("Hello World", backgroundColor: .gray, cornerRadius: 5)
}
