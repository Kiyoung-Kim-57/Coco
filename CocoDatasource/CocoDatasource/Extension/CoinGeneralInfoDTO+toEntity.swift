//
//  CoinGeneralInfoDTO+toEntity.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/23/25.
//

import Foundation
import CocoDomain

public extension CoinGeneralInfoDTO {
    func toCoinListEntity() -> CoinListEntity {
        CoinListEntity(
            market: self.market,
            koreanName: self.koreanName,
            englishName: self.englishName
        )
    }
}
