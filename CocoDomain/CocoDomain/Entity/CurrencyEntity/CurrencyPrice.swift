//
//  CurrencyPrice.swift
//  CocoDomain
//
//  Created by 김기영 on 9/14/25.
//

import Foundation

public struct CurrencyPrice: Decodable {
    public let usd: Double
    public let krw: Double
    
    public init(usd: Double, krw: Double) {
        self.usd = usd
        self.krw = krw
    }
}
