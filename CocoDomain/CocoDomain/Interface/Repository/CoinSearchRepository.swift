//
//  CoinListRepository.swift
//  CocoDomain
//
//  Created by 김기영 on 8/23/25.
//
import Foundation

public protocol CoinSearchRepository {
    func fetchCoinList() async throws -> CoinListEntities
    func fetchCoinThumbnail() async throws -> URL
    func fetchTrendingCoinList() async throws -> TrendingCoinListEntities
    func fetchSearchResults(_ query: String) async throws -> CoinSearchListEntities
}
