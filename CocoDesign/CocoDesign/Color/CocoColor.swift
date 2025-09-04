//
//  CocoColor.swift
//  CocoDesign
//
//  Created by 김기영 on 9/3/25.
//

import SwiftUI

public enum CocoColor {
    public static func resource(_ color: Colors) -> Color {
        switch color {
        case .gray10: return Color(.gray10)
        case .gray20: return Color(.gray20)
        case .gray30: return Color(.gray30)
        case .gray40: return Color(.gray40)
        case .gray50: return Color(.gray50)
        case .gray60: return Color(.gray60)
        case .gray70: return Color(.gray70)
        case .gray80: return Color(.gray80)
        case .gray85: return Color(.gray85)
        case .gray90: return Color(.gray90)
        case .green: return Color(.cocoGreen)
        case .yellow: return Color(.cocoYellow)
        case .primaryPurple: return Color(.primaryPurple)
        }
    }
}

public enum Colors {
    case gray10
    case gray20
    case gray30
    case gray40
    case gray50
    case gray60
    case gray70
    case gray80
    case gray85
    case gray90
    case green
    case yellow
    case primaryPurple
}
