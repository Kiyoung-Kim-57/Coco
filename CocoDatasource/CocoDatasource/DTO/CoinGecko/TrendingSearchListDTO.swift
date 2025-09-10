//
//  TrendingSearchListDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

import Foundation

// MARK: - Main Response Model
public struct TrendingSearchListDTO: Decodable {
    public let coins: [TrendingCoinSearchResult]
    public let nfts: [NFTSearchResult]
    public let categories: [CategorySearchResult]
}

// MARK: - Coin Models
public struct TrendingCoinSearchResult: Decodable {
    public let item: TrendingCoinItem
}

public struct TrendingCoinItem: Decodable {
    public let id: String
    public let coinId: Int
    public let name: String
    public let symbol: String
    public let marketCapRank: Int
    public let thumb: String
    public let score: Int
    public let data: TrendingCoinData
    
    enum CodingKeys: String, CodingKey {
        case id
        case coinId = "coin_id"
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
        case score
        case data
    }
}

public struct TrendingCoinData: Decodable {
    public let price: Double
    public let priceBtc: String
    public let priceChangePercentage24h: PriceDTO
    public let marketCap: String
    public let marketCapBtc: String
    public let totalVolume: String
    public let totalVolumeBtc: String
    public let sparkline: String
    public let content: TrendingCoinContent?
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceBtc = "price_btc"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case sparkline
        case content
    }
}

public struct TrendingCoinContent: Decodable {
    public let title: String
    public let description: String
}

// MARK: - NFT Models
public struct NFTSearchResult: Decodable {
    public let id: String
    public let name: String
    public let symbol: String
    public let thumb: String
    public let nftContractId: Int
    public let nativeCurrencySymbol: String
    public let floorPriceInNativeCurrency: Double
    public let floorPrice24hPercentageChange: Double
    public let data: NFTData
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case thumb
        case nftContractId = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24hPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

public struct NFTData: Decodable {
    public let floorPrice: String
    public let floorPriceInUsd24hPercentageChange: String
    public let h24Volume: String
    public let h24AverageSalePrice: String
    public let sparkline: String
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24hPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
        case sparkline
    }
}

// MARK: - Category Models
public struct CategorySearchResult: Decodable {
    public let id: Int
    public let name: String
    public let marketCap1hChange: Double
    public let slug: String
    public let coinsCount: String
    public let data: CategoryData
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case marketCap1hChange = "market_cap_1h_change"
        case slug
        case coinsCount = "coins_count"
        case data
    }
}

public struct CategoryData: Decodable {
    public let marketCap: Double
    public let marketCapBtc: Double
    public let totalVolume: Double
    public let totalVolumeBtc: Double
    public let marketCapChangePercentage24h: CategoryPriceChangePercentage24h
    public let sparkline: String
    
    enum CodingKeys: String, CodingKey {
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case sparkline
    }
}

public struct CategoryPriceChangePercentage24h: Decodable {
    public let usd: Double
    public let krw: Double
}
