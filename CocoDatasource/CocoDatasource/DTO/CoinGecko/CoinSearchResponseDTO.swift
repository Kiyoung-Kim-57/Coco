//
//  CoinSearchResponseDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/5/25.
//


import Foundation

// 최상위 응답 DTO
public struct CoinSearchResponseDTO: Codable {
    public let coins: [CoinDTO]
}

// Coin 개별 DTO
public struct CoinDTO: Codable, Identifiable {
    public let id: String
    public let name: String
    public let apiSymbol: String
    public let symbol: String
    public let marketCapRank: Int?
    public let thumb: String

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
    }
}
