//
//  FetchCoinDataByIDUseCaseImpl.swift
//  CocoDomain
//
//  Created by 김기영 on 9/15/25.
//

public final class FetchCoinDataByIDUseCaseImpl: FetchCoinDataByIDUseCase {
    public func execute(_ id: String) async throws -> CoinDataByIDEntity{
        try await coinSearchRepository.fetchCoinDataByID(id)
    }
    
    private let coinSearchRepository: CoinSearchRepository
    
    public init(coinSearchRepository: CoinSearchRepository) {
        self.coinSearchRepository = coinSearchRepository
    }
}
