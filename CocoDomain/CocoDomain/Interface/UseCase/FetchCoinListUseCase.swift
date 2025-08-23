//
//  FetchCoinListUseCase.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/23/25.
//

public protocol FetchCoinListUseCase {
    func execute() async throws -> CoinListEntities
}
