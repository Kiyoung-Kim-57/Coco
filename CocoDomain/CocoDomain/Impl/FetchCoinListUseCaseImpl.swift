//
//  FetchCoinListUseCaseImpl.swift
//  CocoDomain
//
//  Created by 김기영 on 8/23/25.
//

public final class FetchCoinListUseCaseImpl: FetchCoinListUseCase {
    public func execute() async throws -> CoinListEntities {
        try await coinListRepository.fetchCoinList()
    }
    
    private let coinListRepository: CoinSearchRepository
    
    public init(coinListRepository: CoinSearchRepository) {
        self.coinListRepository = coinListRepository
    }
}
