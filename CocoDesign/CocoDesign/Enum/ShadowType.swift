//
//  ShadowType.swift
//  Coco
//
//  Created by 김기영 on 8/17/25.
//


import SwiftUI

// MARK: - Shadow Type Enum
public enum ShadowType: CaseIterable {
    case none
    case plain
    case soft
    case strong
    case elevated
    case floating
    
    public var properties: (color: Color, radius: CGFloat, offset: CGSize) {
        switch self {
        case .none:
            return (Color.clear, 0, .zero)
        case .plain:
            return (Color.black.opacity(0.1), 2, CGSize(width: 0, height: 1))
        case .soft:
            return (Color.black.opacity(0.08), 4, CGSize(width: 0, height: 2))
        case .strong:
            return (Color.black.opacity(0.25), 8, CGSize(width: 0, height: 4))
        case .elevated:
            return (Color.black.opacity(0.15), 12, CGSize(width: 0, height: 6))
        case .floating:
            return (Color.black.opacity(0.2), 16, CGSize(width: 0, height: 8))
        }
    }
    
    public var color: Color {
        return properties.color
    }
    
    public var radius: CGFloat {
        return properties.radius
    }
    
    public var offset: CGSize {
        return properties.offset
    }
}
