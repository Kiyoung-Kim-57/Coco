//
//  CoinChartDataEntity.swift
//  CocoDomain
//
//  Created by 김기영 on 9/10/25.
//

import Foundation

public struct CoinChartDataEntity: Codable {
    let date: Date
    let price: Double
    let marketCap: Double
    let totalVolume: Double
    
    public init(date: Date, price: Double, marketCap: Double, totalVolume: Double) {
        self.date = date
        self.price = price
        self.marketCap = marketCap
        self.totalVolume = totalVolume
    }
}

public typealias CoinChartDataEntities = [CoinChartDataEntity]
