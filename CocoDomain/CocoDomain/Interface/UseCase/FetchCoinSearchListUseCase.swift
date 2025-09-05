//
//  FetchCoinSearchListUseCase.swift
//  CocoDomain
//
//  Created by 김기영 on 9/5/25.
//

public protocol FetchCoinSearchListUseCase {
    func execute(_ query: String) async throws  -> CoinSearchListEntities
}
