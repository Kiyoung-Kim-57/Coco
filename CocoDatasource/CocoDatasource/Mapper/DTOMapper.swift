//
//  DTOMapper.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/29/25.
//
import Foundation
import CocoDomain

public enum DTOMapper {
    // Trending Coin
    public enum TrendingCoin {
        public static func map(coinList: [TrendingCoinSearchResult], sparkLine: [Data] ) throws -> TrendingCoinListEntities {
            guard coinList.count == sparkLine.count else {
                throw DataError.dataCountMismatch
            }
            
            var result: TrendingCoinListEntities = []
            
            for (index, coin) in coinList.enumerated() {
                result.append(
                    TrendingCoinListEntity(
                        code: coin.item.symbol,
                        name: coin.item.name,
                        price: coin.item.data.price,
                        changeRate: coin.item.data.priceChangePercentage24h.krw,
                        thumbUrl: coin.item.thumb,
                        rank: coin.item.score,
                        sparkline: sparkLine[index]
                    )
                )
            }
            
            return result
        }
    }
    
    // Coin Search
    public enum CoinSearchList {
        public static func map(response: CoinSearchResponseDTO) -> CoinSearchListEntities {
            return response.coins.map { item in
                CoinSearchListEntity(
                    id: item.id,
                    name: item.name,
                    symbol: item.symbol
                )
            }
        }
    }
    
    // Coin Chart Data
    public enum CoinChartData {
        public static func map(response: CoinChartDTO) -> CoinHistoricalChartDataEntities {
            var result: CoinHistoricalChartDataEntities = []
            for idx in 0..<response.prices.count {
                let temp = CoinHistoricalChartDataEntity(
                    date: Date(milliseconds: response.prices[idx][0]),
                    price: response.prices[idx][1],
                    marketCap: response.marketCaps[idx][1],
                    totalVolume: response.totalVolumes[idx][1]
                )
                
                result.append(temp)
            }
            
            return result
        }
    }
    
    // Coin Data by ID
    public enum CoinData {
        public static func map(response: CoinDataDTO) -> CoinDataByIDEntity {
            CoinDataByIDEntity(
                id: response.id,
                symbol: response.symbol,
                name: response.name,
                categories: response.categories,
                currentPrice: response.marketData.currentPrice.toEntity(),
                ath: response.marketData.ath.toEntity(),
                athChangePercentage: response.marketData.athChangePercentage.toEntity(),
                athDate: response.marketData.athDate.toEntity(),
                atl: response.marketData.atl.toEntity(),
                atlChangePercentage: response.marketData.atlChangePercentage.toEntity(),
                atlDate: response.marketData.atlDate.toEntity(),
                sparkLine: response.marketData.sparkline7d.price,
                lastUpdated: response.lastUpdated
            )
        }
    }
}
