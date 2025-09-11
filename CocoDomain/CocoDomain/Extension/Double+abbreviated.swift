//
//  Double+abbreviated.swift
//  CocoDomain
//
//  Created by 김기영 on 9/11/25.
//

import Foundation

public extension Double {
    var abbreviated: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        if self >= 1_000_000_000 {
            formatter.positiveSuffix = "B"
            return formatter.string(from: NSNumber(value: self / 1_000_000_000)) ?? "\(self)"
        } else if self >= 1_000_000 {
            formatter.positiveSuffix = "M"
            return formatter.string(from: NSNumber(value: self / 1_000_000)) ?? "\(self)"
        } else if self >= 1_000 {
            formatter.positiveSuffix = "K"
            return formatter.string(from: NSNumber(value: self / 1_000)) ?? "\(self)"
        } else {
            return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        }
    }
}
