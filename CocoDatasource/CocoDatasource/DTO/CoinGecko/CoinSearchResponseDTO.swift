//
//  CoinSearchResponseDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/5/25.
//


import Foundation

// 최상위 응답 DTO
struct CoinSearchResponseDTO: Codable {
    let coins: [CoinDTO]
}

// Coin 개별 DTO
struct CoinDTO: Codable, Identifiable {
    let id: String
    let name: String
    let apiSymbol: String
    let symbol: String
    let marketCapRank: Int?
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
    }
}
