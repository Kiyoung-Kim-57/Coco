//
//  FetchTrendingSearchUseCaseImpl.swift
//  CocoDomain
//
//  Created by 김기영 on 8/26/25.
//

public final class FetchTrendingSearchUseCaseImpl: FetchTrendingSearchUseCase {
    public func execute() async throws -> TrendingCoinListEntities {
        try await coinSearchRepository.fetchTrendingCoinList()
    }
    
    private let coinSearchRepository: CoinSearchRepository
    
    public init(coinSearchRepository: CoinSearchRepository) {
        self.coinSearchRepository = coinSearchRepository
    }
}
