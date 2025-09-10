//
//  FetchCoinChartDataUseCase.swift
//  CocoDomain
//
//  Created by 김기영 on 9/10/25.
//

public protocol FetchCoinChartDataUseCase {
    func execute(_ coin: String) async throws -> CoinChartDataEntities
}
