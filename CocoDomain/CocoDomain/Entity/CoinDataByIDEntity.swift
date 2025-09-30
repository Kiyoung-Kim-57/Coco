//
//  CoinDetailEntity.swift
//  CocoDomain
//
//  Created by 김기영 on 9/14/25.
//

import Foundation

public struct CoinDataByIDEntity: Decodable, Equatable {
    public let id: String
    public let symbol: String
    public let name: String
    public let categories: [String]
    public let currentPrice: CurrencyPrice
    public let ath: CurrencyPrice
    public let athChangePercentage: CurrencyPercentage
    public let athDate: CurrencyDate
    public let atl: CurrencyPrice
    public let atlChangePercentage: CurrencyPercentage
    public let atlDate: CurrencyDate
    public let sparkLine: [Double]
    public let lastUpdated: String
    
    public init(
        id: String,
        symbol: String,
        name: String,
        categories: [String],
        currentPrice: CurrencyPrice,
        ath: CurrencyPrice,
        athChangePercentage: CurrencyPercentage,
        athDate: CurrencyDate,
        atl: CurrencyPrice,
        atlChangePercentage: CurrencyPercentage,
        atlDate: CurrencyDate,
        sparkLine: [Double],
        lastUpdated: String
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.categories = categories
        self.currentPrice = currentPrice
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.sparkLine = sparkLine
        self.lastUpdated = lastUpdated
    }
}
