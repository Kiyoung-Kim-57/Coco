//
//  TrendingSearchListDTO+toEntity.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

import CocoDomain

public extension TrendingSearchListDTO {
    
    func toEntity() -> TrendingCoinListEntities {
        return self.coins[0..<10].map { coin in
            TrendingCoinListEntity(
                code: coin.item.symbol,
                name: coin.item.name,
                price: coin.item.data.price,
                changeRate: coin.item.data.priceChangePercentage24h.krw,
                thumbUrl: coin.item.thumb,
                rank: coin.item.score,
                sparklineUrl: coin.item.data.sparkline
            )
        }
    }
}
