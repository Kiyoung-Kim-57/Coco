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
    private let fetchUseCase: any FetchCoinListUseCase
    init() {
        DIContainer.registerObjects()
        self.fetchUseCase = DIContainer.resolveFetchCoinListUseCase()
    }
    
    @Test("Fetch Coin List Test")
    func fetchCoinListTest() async throws {
        let coinListResponse = try await fetchUseCase.execute()
        print(coinListResponse.description)
        #expect(coinListResponse.count > 0)
    }
}
