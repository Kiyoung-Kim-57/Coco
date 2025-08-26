//
//  CoinListRepositoryImpl.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/23/25.
//

import Foundation
import CocoDomain
import CocoNetwork

public final class CoinSeachRepositoryImpl: CoinSearchRepository {
    private let upbitRemoteDataSource: any CocoRemoteDataSource
    private let geckoRemoteDataSource: any CocoRemoteDataSource
    
    public init(upbitRemoteDataSource: any CocoRemoteDataSource, geckRemoteDataSource: any CocoRemoteDataSource) {
        self.upbitRemoteDataSource = upbitRemoteDataSource
        self.geckoRemoteDataSource = geckRemoteDataSource
    }
    
    public func fetchCoinList() async throws -> CoinListEntities {
        let response = try await upbitRemoteDataSource.readData(type: CoinGeneralInfoDTOs.self) { request in
            request
                .setURLPath(path: Upbit.marketPath())
        }
        
        return response.map { $0.toCoinListEntity() }
    }
    
    public func fetchCoinThumbnail() async throws -> URL {
        return URL(filePath: "")
    }
    
    public func fetchTrendingCoinList() async throws -> TrendingCoinListEntities {
        let response = try await geckoRemoteDataSource.readData(type: TrendingSearchListDTO.self) { request in
            request
                .setURLPath(path: Gecko.trendingPath())
        }
        
        return response.toEntity()
    }
}
