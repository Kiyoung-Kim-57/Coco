//
//  Date+Format.swift
//  CocoPresent
//
//  Created by 김기영 on 9/5/25.
//

import Foundation

extension DateFormatter {
    static func cocoFormatter(_ date: Date, _ formatType: CocoDateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatType.format
        return formatter.string(from: date)
    }
}

enum CocoDateFormat {
    case yyyyMMdd
    case yyyyMMddHHmmss
    
    case MMddHHmm
    
    var format: String {
        switch self {
        case .yyyyMMdd:
            "yyyy-MM-dd"
        case .yyyyMMddHHmmss:
            "yyyy-MM-dd HH:mm:ss"
        case .MMddHHmm:
            "MM.dd HH:mm"
        }
    }
}
