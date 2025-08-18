//
//  ViewContainer.swift
//  CocoDesign
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI

public struct CocoContainer<Content: View>: View {
    private let width: CGFloat
    private let height: CGFloat
    private let backgroundColor: Color
    private let lineColor: Color
    private let cornerRadius: CGFloat
    private let borderColor: Color
    private let borderWidth: CGFloat
    private let shadowType: ShadowType
    private let contentPadding: EdgeInsets
    private let content: Content
    
    public init(
        width: CGFloat = 0,
        height: CGFloat = 0,
        backgroundColor: Color = .white,
        lineColor: Color = .clear ,
        cornerRadius: CGFloat = 8,
        borderColor: Color = .black,
        borderWidth: CGFloat = 0,
        shadowType: ShadowType = .none,
        contentPadding: EdgeInsets = EdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        ),
        @ViewBuilder content: () -> Content
    ) {
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.lineColor = lineColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowType = shadowType
        self.contentPadding = contentPadding
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(contentPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .shadowType(shadowType)
    }
}
