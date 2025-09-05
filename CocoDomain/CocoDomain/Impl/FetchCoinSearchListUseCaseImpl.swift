//
//  FetchCoinSearchListUseCaseImpl.swift
//  CocoDomain
//
//  Created by 김기영 on 9/5/25.
//

public struct FetchCoinSearchListUseCaseImpl: FetchCoinSearchListUseCase {
    public func execute(_ query: String) async throws -> CoinSearchListEntities {
        return try await coinSearchRepository.fetchSearchResults(query)
    }
    
    private let coinSearchRepository: CoinSearchRepository
    
    public init(coinSearchRepository: CoinSearchRepository) {
        self.coinSearchRepository = coinSearchRepository
    }
}
