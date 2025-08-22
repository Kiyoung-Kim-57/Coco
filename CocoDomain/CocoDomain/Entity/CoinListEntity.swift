//
//  CryptoCurrencyMarket.swift
//  CocoDomain
//
//  Created by 김기영 on 8/23/25.
//

import Foundation

// MARK: - Main Market Data Structure
public struct CoinListEntity: Codable {
    public let market: String
    public let koreanName: String
    public let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

// MARK: - Typealias for convenience
public typealias CoinListEntities = [CoinListEntity]
