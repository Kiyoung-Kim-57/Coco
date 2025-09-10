//
//  DependencyValues.swift
//  CocoPresent
//
//  Created by 김기영 on 8/26/25.
//
import Dependencies
import CocoDomain

public extension DependencyValues {
    var fetchTrendingSearchUseCase: FetchTrendingSearchUseCase {
        get { self[FetchTrendingSearchUseCaseKey.self] }
        set { self[FetchTrendingSearchUseCaseKey.self] = newValue }
    }
    
    var fetchCoinSearchListUseCase: FetchCoinSearchListUseCase {
        get { self[FetchCoinSearchListUseCaseKey.self] }
        set { self[FetchCoinSearchListUseCaseKey.self] = newValue }
    }
    
    var fetchCoinChartDataUseCase: FetchCoinChartDataUseCase {
        get { self[FetchCoinChartDataUseCaseKey.self] }
        set { self[FetchCoinChartDataUseCaseKey.self] = newValue }
    }
}
