//
//  CurrencyDate.swift
//  CocoDomain
//
//  Created by 김기영 on 9/14/25.
//


public struct CurrencyDate: Decodable, Equatable {
    public let krw: String
    public let usd: String
    
    public init(krw: String, usd: String) {
        self.krw = krw
        self.usd = usd
    }
}
