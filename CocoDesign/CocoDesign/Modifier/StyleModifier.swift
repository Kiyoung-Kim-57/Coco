//
//  StyleModifier.swift
//  CocoDesign
//
//  Created by 김기영 on 9/1/25.
//

import SwiftUI

public enum StyleType {
    case thumb
}

public struct StyleModifier: ViewModifier {
    
    let type: StyleType
    
    public func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            }
            .shadowType(.soft)
    }
}

public extension View {
    func thumb() -> some View {
        modifier(StyleModifier(type: .thumb))
    }
}
