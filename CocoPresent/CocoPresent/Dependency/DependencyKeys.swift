//
//  DependencyKeys.swift
//  CocoPresent
//
//  Created by 김기영 on 8/26/25.
//

import CocoDIContainer
import CocoDomain
import Dependencies

public enum FetchTrendingSearchUseCaseKey: DependencyKey {
    public static let liveValue = DIContainer.resolveFetchTrendingSearchUseCase()
}

public enum FetchCoinSearchListUseCaseKey: DependencyKey {
    public static let liveValue = DIContainer.resolveFetchCoinSearchListUseCase()
}
