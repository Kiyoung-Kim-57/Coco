//
//  CoinListRepositoryImpl.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/23/25.
//

import Foundation
import CocoDomain
import CocoNetwork

public final class CoinListRepositoryImpl: CoinListRepository {
    private let remoteDataSource: any CocoRemoteDataSource
    
    public init(remoteDataSource: any CocoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchCoinList() async throws -> CoinListEntities {
        let response = try await remoteDataSource.readData(type: CoinGeneralInfoDTOs.self) { request in
            request
                .setURLPath(path: "/v1/market/all")
        }
        
        return response.map { $0.toCoinListEntity() }
    }
    
    public func fetchCoinThumbnail() async throws -> URL {
        return URL(filePath: "")
    }
    
}
