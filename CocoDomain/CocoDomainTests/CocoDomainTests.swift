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
    init() {
        DIContainer.registerObjects()
        self.fetchUseCase = DIContainer.resolveFetchTrendingSearchUseCase()
    }
    
    @Test("Fetch Coin List Test")
    func fetchCoinListTest() async throws {
        let coinListResponse = try await fetchUseCase.execute()
        print(coinListResponse.description)
        #expect(coinListResponse.count > 0)
    }
}
