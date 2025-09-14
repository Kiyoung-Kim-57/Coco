//
//  PriceDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/10/25.
//

import Foundation
import CocoDomain

public struct CurrencyPriceDTO: Decodable {
    public let usd: Double
    public let krw: Double
}

public extension CurrencyPriceDTO {
    func toEntity() -> CurrencyPrice {
        CurrencyPrice(usd: usd, krw: krw)
    }
}
