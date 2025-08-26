//
//  CocoDatasourceTests.swift
//  CocoDatasourceTests
//
//  Created by 김기영 on 7/25/25.
//

import Foundation
import Testing
import CocoNetwork
import CocoDatasource

@Suite("Remote Datasource Test")
struct CocoDatasourceTests {
    private var networkManager: NetworkManager
    private var upbitRemoteDatasource: any CocoRemoteDataSource
    private var coinGeckoRemoteDatasource: any CocoRemoteDataSource
    
    init() {
        self.networkManager = NetworkManagerImpl()
        
        self.upbitRemoteDatasource = CocoRemoteDataSourceImpl(
            networkManager: self.networkManager,
            baseHost: DataSourceBundle.upbitHost()
        )
        
        self.coinGeckoRemoteDatasource = CocoRemoteDataSourceImpl(
            networkManager: self.networkManager,
            baseHost: DataSourceBundle.geckoHost()
        )
    }
    
    @Test("Upbit Read Data Test")
    func readData() async throws {
        let data = try await upbitRemoteDatasource.readData { request in
            request
                .setURLPath(path: "/v1/market/all")
        }
        
        #expect(data.count > 0)
    }
    
    @Test("Upbit Read Data Decoding Test")
    func readDataDecoding() async throws {
        let markets: CoinGeneralInfoDTOs = try await upbitRemoteDatasource.readData(type: CoinGeneralInfoDTOs.self) { request in
            request
                .setURLPath(path: "/v1/market/all")
        }
        
        #expect(markets.count > 0)
        if let first = markets.first {
            print("Response Sample: \(first)")
        }
    }
    
    @Test("Upbit Read Data Query Test")
    func readDataUsedQuery() async throws {
        let markets: CoinGeneralInfoDTOs = try await upbitRemoteDatasource.readData(type: CoinGeneralInfoDTOs.self) { request in
            request
                .setURLPath(path: "/v1/market/all")
                .addQueryItem("is_details", "true")
        }
        
        #expect(!markets.isEmpty)
        if let first = markets.first {
            print("Response: \(first)")
            #expect(first.marketEvent != nil)
        }
    }
    
    @Test("Gecko Read Data Test")
    func geckoReadData() async throws {
        let data = try await coinGeckoRemoteDatasource.readData { request in
            request
                .setURLPath(path: "/api/v3/search")
                .addQueryItem("query", "ethereum")
        }
        
        let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        print(dict.description)
        #expect(data.count > 0)
    }
}

enum TestErrors: Error {
    case readDataFailed
}
