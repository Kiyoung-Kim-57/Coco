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
        public static func map(response: CoinChartDTO) -> CoinChartDataEntities {
            var result: CoinChartDataEntities = []
            for idx in 0..<response.prices.count {
                var temp = CoinChartDataEntity(
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
}
