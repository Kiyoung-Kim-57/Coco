//
//  TrendingCoinListEntity.swift
//  CocoDomain
//
//  Created by 김기영 on 8/26/25.
//
import Foundation

public struct TrendingCoinListEntity: Comparable, Hashable {
    public let code: String
    public let name: String
    public let price: Double
    public let changeRate: Double
    public let thumbUrl: String?
    public let rank: Int
    public let sparkline: Data
    
    public init(code: String, name: String, price: Double, changeRate: Double, thumbUrl: String?, rank: Int, sparkline: Data) {
        self.code = code
        self.name = name
        self.price = price
        self.changeRate = changeRate
        self.thumbUrl = thumbUrl
        self.rank = rank
        self.sparkline = sparkline
    }
    // Comparable
    public static func < (lhs: TrendingCoinListEntity, rhs: TrendingCoinListEntity) -> Bool {
        return lhs.rank < rhs.rank
    }
}

public typealias TrendingCoinListEntities = [TrendingCoinListEntity]
