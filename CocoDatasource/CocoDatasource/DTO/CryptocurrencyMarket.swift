//
//  CryptocurrencyMarket.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/11/25.
//

import Foundation

// MARK: - Main Market Data Structure
public struct CryptocurrencyMarket: Codable {
    let market: String
    let koreanName: String
    let englishName: String
    let marketEvent: MarketEvent?
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
        case marketEvent = "market_event"
    }
}

// MARK: - Typealias for convenience
public typealias CryptocurrencyMarkets = [CryptocurrencyMarket]
