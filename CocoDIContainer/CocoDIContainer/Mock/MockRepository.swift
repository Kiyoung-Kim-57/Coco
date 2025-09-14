//
//  MockRepository.swift
//  CocoDIContainer
//
//  Created by 김기영 on 9/7/25.
//
import Foundation
import CocoDomain

public final class MockRepository: CoinSearchRepository {
    public func fetchCoinDataByID(_ id: String) async throws -> CocoDomain.CoinDataByIDEntity {
        return CoinDataByIDEntity(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            categories: ["testing"],
            currentPrice: CurrencyPrice(usd: 1230, krw: 222),
            ath: CurrencyPrice(usd: 1230, krw: 12351),
            athChangePercentage: CurrencyPercentage(usd: 20, krw: 20),
            athDate: CurrencyDate(krw: "2025-11-11", usd: "2025-11-11"),
            atl: CurrencyPrice(usd: 1230, krw: 12351),
            atlChangePercentage: CurrencyPercentage(usd: 20, krw: 20),
            atlDate: CurrencyDate(krw: "1111", usd: "1111"),
            sparkLine: [100,120,130,150,145,120,134],
            lastUpdated: "2025-11-11"
        )
    }
    
    public func fetchCoinChartData(_ coin: String) async throws -> CocoDomain.CoinHistoricalChartDataEntities {
        []
    }
    
    public func fetchCoinList() async throws -> CocoDomain.CoinListEntities {
        []
    }
    
    public func fetchCoinThumbnail() async throws -> URL {
        URL(string: "")!
    }
    
    public func fetchTrendingCoinList() async throws -> CocoDomain.TrendingCoinListEntities {
        [TrendingCoinListEntity(code: "bitcoin", name: "Bitcoin", price: 100, changeRate: 100, thumbUrl: nil, rank: 0, sparkline: Data())]
    }
    
    public func fetchSearchResults(_ query: String) async throws -> CocoDomain.CoinSearchListEntities {
        [CoinSearchListEntity(id: "bitcoin", name: "BitCoin", symbol: "BTC")]
    }
}
