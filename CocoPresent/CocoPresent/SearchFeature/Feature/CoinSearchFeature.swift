//
//  CoinSearchFeature.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture

public struct CoinSearchFeature: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var searchText: String = ""
        
        // Sub Feature State
        var searchListState = SearchListFeature.State()
        var trendingSearchState = TrendingSearchFeature.State()
    }
    
    @CasePathable
    public enum Action {
        case searchTextChanged(String)
        
        // Sub Feature Action
        case searchList(SearchListFeature.Action)
        case trendingSearch(TrendingSearchFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .trendingSearch(_):
                return .none
            case .searchList(_):
                return .none
            case .searchTextChanged(let text):
                guard state.searchText != text else { return .none }
                state.searchText = text
                return .run { send in
                    // TODO: Search Task Needed
                    if text.isEmpty {
                        await send(.searchList(.searchCanceled))
                    } else {
                        await send(.searchList(.searchResultFetched(SearchListFeature.dummyData)))
                    }
                }
            }
        }
        
        // MARK: Scope
        Scope(state: \.searchListState, action: \.searchList) {
            SearchListFeature()
        }
        
        Scope(state: \.trendingSearchState, action: \.trendingSearch) {
            TrendingSearchFeature()
        }
    }
}
