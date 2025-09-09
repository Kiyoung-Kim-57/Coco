//
//  CocoDomainTests.swift
//  CocoDomainTests
//
//  Created by 김기영 on 8/23/25.
//

import Testing
import CocoDIContainer
import CocoDomain

@Suite("Domain UseCase Test")
struct CocoDomainTests {
    private let fetchUseCase: any FetchTrendingSearchUseCase
    private let fetchCoinSearchListUseCase: any FetchCoinSearchListUseCase
    init() {
        DIContainer.registerCoinSearchRepositoryMock()
        let repo = DIContainer.shared.resolve(CoinSearchRepository.self, mode: .mock)
        self.fetchUseCase =  FetchTrendingSearchUseCaseImpl(coinSearchRepository: repo)
        self.fetchCoinSearchListUseCase = FetchCoinSearchListUseCaseImpl(coinSearchRepository: repo)
    }
    
    @Test("Fetch Coin List Test")
    func fetchCoinListTest() async throws {
        let coinListResponse = try await fetchUseCase.execute()
        print(coinListResponse.description)
        #expect(coinListResponse.count > 0)
    }
    
    @Test("Fetch Coin Search List Test")
    func fecthCoinSearchListTest() async throws {
        let coinSearchListResponse = try await fetchCoinSearchListUseCase.execute("bitcoin")
        print(coinSearchListResponse.description)
        #expect(coinSearchListResponse.contains(where: { $0.id == "bitcoin" }))
    }
}
