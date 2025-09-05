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
        public static func map(response: CoinSearchResponseDTO) throws -> CoinListEntities {
            return []
        }
    }
}
