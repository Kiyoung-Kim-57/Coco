//
//  MarketEvent.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/11/25.
//


// MARK: - Market Event Structure
public struct MarketEvent: Codable {
    let warning: Bool
    let caution: CautionDTO
}

