//
//  CoinChartDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/10/25.
//

import Foundation

public struct CoinChartDTO: Codable {
    let prices: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
