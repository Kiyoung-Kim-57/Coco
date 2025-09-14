//
//  CurrencyDateDTO.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/13/25.
//

import Foundation
import CocoDomain

public struct CurrencyDateDTO: Decodable {
    public let krw: String
    public let usd: String
}

public extension CurrencyDateDTO {
    func toEntity() -> CurrencyDate {
        return CurrencyDate(krw: self.krw, usd: self.usd )
    }
}
