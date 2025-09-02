//
//  FetchTrendingSearchUseCase.swift
//  CocoDomain
//
//  Created by 김기영 on 8/26/25.
//

public protocol FetchTrendingSearchUseCase {
    func execute() async throws -> TrendingCoinListEntities
}
