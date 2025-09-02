//
//  ShadowTypeModifier.swift
//  Coco
//
//  Created by 김기영 on 8/17/25.
//
import SwiftUI

// MARK: - Custom Shadow Modifier
public struct ShadowModifier: ViewModifier {
    let shadowType: ShadowType
    
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: shadowType.color,
                radius: shadowType.radius,
                x: shadowType.offset.width,
                y: shadowType.offset.height
            )
    }
}

// MARK: - View Extension
public extension View {
    func shadow(_ type: ShadowType) -> some View {
        self.modifier(ShadowModifier(shadowType: type))
    }
}
