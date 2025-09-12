//
//  NumberFormatter.swift
//  CocoPresent
//
//  Created by 김기영 on 9/12/25.
//

import Foundation

extension NumberFormatter {
    static func currency(code: CocoCurrency, price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code.rawValue
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(for: price) ?? ""
    }
    
    enum CocoCurrency: String {
        case usd
        case krw
    }
}
