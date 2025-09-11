//
//  MockRepository.swift
//  CocoDIContainer
//
//  Created by 김기영 on 9/7/25.
//
import Foundation
import CocoDomain

public final class MockRepository: CoinSearchRepository {
    public func fetchCoinChartData(_ coin: String) async throws -> CocoDomain.CoinChartDataEntities {
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
