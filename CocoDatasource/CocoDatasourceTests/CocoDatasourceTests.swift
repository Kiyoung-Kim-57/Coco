//
//  CocoDatasourceTests.swift
//  CocoDatasourceTests
//
//  Created by 김기영 on 7/25/25.
//

import Testing
import CocoNetwork
import CocoDatasource

@Suite("Remote Datasource Test")
struct CocoDatasourceTests {
    private var networkManager: NetworkManager
    private var remoteDatasource: CocoRemoteDataSource
    
    init() {
        self.networkManager = NetworkManagerImpl()
        self.remoteDatasource = CocoRemoteDataSource(networkManager: self.networkManager)
    }
    
    @Test("Read Data Test")
    func readData() async throws {
        let data = try await remoteDatasource.readData { request in
            request
                .setURLPath(path: "api.upbit.com/v1/market/all")
        }
        
        #expect(data.count > 0)
    }
    
    @Test("Read Data Decoding Test")
    func readDataDecoding() async throws {
        let markets: CryptocurrencyMarkets = try await remoteDatasource.readData(type: CryptocurrencyMarkets.self) { request in
            request
                .setURLPath(path: "api.upbit.com/v1/market/all")
        }
        
        print("Response: \(markets.description)")
        
        #expect(markets.count > 0)
    }
}

enum TestErrors: Error {
    case readDataFailed
}
