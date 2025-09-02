//
//  CryptocurrencyMarket.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/11/25.
//

import Foundation

// MARK: - Main Market Data Structure, Upbit
public struct CoinGeneralInfoDTO: Codable {
    public let market: String
    public let koreanName: String
    public let englishName: String
    public let marketEvent: MarketEvent?
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
        case marketEvent = "market_event"
    }
}

// MARK: - Typealias for convenience
public typealias CoinGeneralInfoDTOs = [CoinGeneralInfoDTO]
