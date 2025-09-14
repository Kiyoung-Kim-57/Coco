//
//  FetchCoinDataByIDUseCase.swift
//  CocoDomain
//
//  Created by 김기영 on 9/15/25.
//

public protocol FetchCoinDataByIDUseCase {
    func execute(_ id: String) async throws -> CoinDataByIDEntity
}
