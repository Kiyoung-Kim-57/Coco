//
//  CoinPriceDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public typealias CoinPriceResults = [String: CoinPriceDTO]

public struct CoinPriceDTO: Decodable {
    let usd: Double?
    let krw: Double?
    
    // Market data (optional parameters)
    let usdMarketCap: Double?
    let krwMarketCap: Double?
    let usd24hVol: Double?
    let krw24hVol: Double?
    let usd24hChange: Double?
    let krw24hChange: Double?
    
    enum CodingKeys: String, CodingKey {
        case usd, krw
        case usdMarketCap = "usd_market_cap"
        case krwMarketCap = "krw_market_cap"
        case usd24hVol = "usd_24h_vol"
        case krw24hVol = "krw_24h_vol"
        case usd24hChange = "usd_24h_change"
        case krw24hChange = "krw_24h_change"
    }
}
