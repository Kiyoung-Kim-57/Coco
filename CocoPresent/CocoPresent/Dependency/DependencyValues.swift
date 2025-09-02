//
//  DependencyValues.swift
//  CocoPresent
//
//  Created by 김기영 on 8/26/25.
//
import Dependencies
import CocoDomain

public extension DependencyValues {
    var fetchTrendingSearchUseCase: FetchTrendingSearchUseCaseImpl {
        get { self[FetchTrendingSearchUseCaseKey.self] }
        set { self[FetchTrendingSearchUseCaseKey.self] = newValue }
    }
}
