
//
//  PercentageDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/13/25.
//

import Foundation
import CocoDomain

public struct CurrencyPercentageDTO: Decodable {
    public let usd: Double
    public let krw: Double
}

public extension CurrencyPercentageDTO {
    func toEntity() -> CurrencyPercentage {
        CurrencyPercentage(usd: usd, krw: krw)
    }
}
