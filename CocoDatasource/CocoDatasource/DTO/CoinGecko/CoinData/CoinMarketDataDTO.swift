//
//  CoinMarketDataDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/13/25.
//

public struct CoinMarketDataDTO: Decodable {
    public let currentPrice: CurrencyPriceDTO
    public let totalValueLocked: Double?
    public let mcapToTvlRatio: Double?
    public let fdvToTvlRatio: Double?
    public let roi: Double?
    public let ath: CurrencyPriceDTO
    public let athChangePercentage: CurrencyPercentageDTO
    public let athDate: CurrencyDateDTO
    public let atl: CurrencyPriceDTO
    public let atlChangePercentage: CurrencyPercentageDTO
    public let atlDate: CurrencyDateDTO
    public let marketCap: CurrencyPriceDTO
    public let marketCapRank: Int
    public let fdv: CurrencyPriceDTO?
    public let marketCapFDVRatio: Double?
    public let totalVolume: CurrencyPriceDTO
    public let high24h: CurrencyPriceDTO
    public let low24h: CurrencyPriceDTO
    public let priceChange24h: Double
    public let priceChangePercentage24h: Double
    public let priceChangePercentage7d: Double
    public let priceChangePercentage14d: Double
    public let priceChangePercentage30d: Double
    public let priceChangePercentage60d: Double
    public let priceChangePercentage200d: Double
    public let priceChangePercentage1y: Double
    public let marketCapChange24h: Double
    public let marketCapChangePercentage24h: Double
    public let priceChange24hInCurrency: CurrencyPriceDTO
    public let priceChangePercentage1hInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage24hInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage7dInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage14dInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage30dInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage60dInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage200dInCurrency: CurrencyPercentageDTO
    public let priceChangePercentage1yInCurrency: CurrencyPercentageDTO
    public let marketCapChange24hInCurrency: CurrencyPriceDTO
    public let marketCapChangePercentage24hInCurrency: CurrencyPercentageDTO
    public let totalSupply: Double
    public let maxSupply: Double?
    public let maxSupplyInfinite: Bool
    public let circulatingSupply: Double
    public let sparkline7d: SparklineDTO
    public let lastUpdated: String
    
    public enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case totalValueLocked = "total_value_locked"
        case mcapToTvlRatio = "mcap_to_tvl_ratio"
        case fdvToTvlRatio = "fdv_to_tvl_ratio"
        case roi
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fdv = "fully_diluted_valuation"
        case marketCapFDVRatio = "market_cap_fdv_ratio"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case priceChangePercentage7d = "price_change_percentage_7d"
        case priceChangePercentage14d = "price_change_percentage_14d"
        case priceChangePercentage30d = "price_change_percentage_30d"
        case priceChangePercentage60d = "price_change_percentage_60d"
        case priceChangePercentage200d = "price_change_percentage_200d"
        case priceChangePercentage1y = "price_change_percentage_1y"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case priceChange24hInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1hInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7dInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14dInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30dInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60dInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200dInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1yInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24hInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24hInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case maxSupplyInfinite = "max_supply_infinite"
        case circulatingSupply = "circulating_supply"
        case sparkline7d = "sparkline_7d"
        case lastUpdated = "last_updated"
    }
}

public struct SparklineDTO: Decodable {
    public let price: [Double]
}
