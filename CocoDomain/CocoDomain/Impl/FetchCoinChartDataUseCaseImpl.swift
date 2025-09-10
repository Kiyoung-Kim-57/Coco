//
//  FetchCoinChartDataUseCaseImpl.swift
//  CocoDomain
//
//  Created by 김기영 on 9/10/25.
//

public final class FetchCoinChartDataUseCaseImpl: FetchCoinChartDataUseCase {
    public func execute(_ coin: String) async throws -> CoinChartDataEntities {
        try await coinSearchRepository.fetchCoinChartData(coin)
    }
    
    private let coinSearchRepository: CoinSearchRepository
    
    public init(coinSearchRepository: CoinSearchRepository) {
        self.coinSearchRepository = coinSearchRepository
    }
}
