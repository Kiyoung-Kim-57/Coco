//
//  CurrencyPercentage.swift
//  CocoDomain
//
//  Created by 김기영 on 9/14/25.
//

public struct CurrencyPercentage: Decodable {
    public let usd: Double
    public let krw: Double
    
    public init(usd: Double, krw: Double) {
        self.usd = usd
        self.krw = krw
    }
}
