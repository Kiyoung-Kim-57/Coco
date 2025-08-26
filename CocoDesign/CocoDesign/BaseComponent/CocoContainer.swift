//
//  ViewContainer.swift
//  CocoDesign
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI

public struct CocoContainer<Content: View>: View {
    private let contentSize: CGSize?
    private let backgroundColor: Color
    private let lineColor: Color
    private let cornerRadius: CGFloat
    private let borderColor: Color
    private let borderWidth: CGFloat
    private let shadowType: ShadowType
    private let contentPadding: EdgeInsets
    private let content: Content
    
    public init(
        contentSize: CGSize? = nil,
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
        self.contentSize = contentSize
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
        if let contentSize = contentSize {
            content
                .frame(width: contentSize.width, height: contentSize.height)
                .padding(contentPadding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(backgroundColor)
                        .shadowType(shadowType)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .inset(by: borderWidth / 2)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        } else {
            content
                .padding(contentPadding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(backgroundColor)
                        .shadowType(shadowType)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .inset(by: borderWidth / 2)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        }
    }
}
