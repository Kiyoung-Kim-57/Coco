//
//  TrendingSearchFeature.swift
//  CocoPresent
//
//  Created by 김기영 on 8/26/25.
//

import SwiftUI
import CocoDomain
import ComposableArchitecture

public struct TrendingSearchFeature: Reducer {
    
    @Dependency(\.fetchTrendingSearchUseCase) var fetchTrendingSearchUseCase
    
    public struct State: Equatable {
        public init() { }
        
        var coinList: [TrendingCoinListEntity] = []
        var isLoading: Bool = false
        var searchDate: String = DateFormatter.cocoFormatter(Date.now, .MMddHHmm)
    }
    
    public enum Action {
        case onAppear
        case dataLoaded([TrendingCoinListEntity])
        case dataLoadFailed(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard !state.isLoading && state.coinList.isEmpty else { return .none }
                
                state.isLoading = true
                return .run { send in
                    do {
                        let list = try await self.fetchTrendingSearchUseCase.execute()
                        await send(.dataLoaded(list))
                    } catch {
                        print("Error Occured: \(error)")
                        await send(.dataLoadFailed(error))
                    }
                }
            case .dataLoaded(let list):
                state.coinList = list
                state.searchDate = DateFormatter.cocoFormatter(Date.now, .MMddHHmm)
                state.isLoading = false
                return .none
            case .dataLoadFailed(let error):
                // TODO: 에러 처리 필요
                state.isLoading = false
                return .none
            }
        }
    }
}
