//
//  Caution.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/11/25.
//

// MARK: - Caution Structure
public struct Caution: Codable {
    let priceFluctuations: Bool
    let tradingVolumeSoaring: Bool
    let depositAmountSoaring: Bool
    let globalPriceDifferences: Bool
    let concentrationOfSmallAccounts: Bool
    
    enum CodingKeys: String, CodingKey {
        case priceFluctuations = "PRICE_FLUCTUATIONS"
        case tradingVolumeSoaring = "TRADING_VOLUME_SOARING"
        case depositAmountSoaring = "DEPOSIT_AMOUNT_SOARING"
        case globalPriceDifferences = "GLOBAL_PRICE_DIFFERENCES"
        case concentrationOfSmallAccounts = "CONCENTRATION_OF_SMALL_ACCOUNTS"
    }
}
