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
        await #expect(throws: TestErrors.readDataFailed) {
            let data = try await remoteDatasource.readData { request in
                request
                    .setURLPath(path: "")
                    .addHeader(key: "", value: "")
                    .addQueryItem("", "")
                    .changeQueryItemValue("", "")

            }
        }
    }

}

enum TestErrors: Error {
    case readDataFailed
}
