//
//  Currency.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public enum Currency: String, CaseIterable {
    case krw
    case usd
    
    var array: [String] {
        return Self.allCases.map { $0.rawValue }
    }
}
