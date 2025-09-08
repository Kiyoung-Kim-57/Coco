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
    
    @Dependency(\.fetchCoinSearchListUseCase) var fetchCoinSearchListUseCase
    
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
    
    private enum ID: Hashable {
        case debounce
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
                        do {
                            let searchResults = try await fetchCoinSearchListUseCase.execute(text)
                            await send(.searchList(.searchResultFetched(searchResults.map { $0.name })))
                        } catch {
                            print("Error Occured: \(error)")
                        }
                    }
                }
                .debounce(id: ID.debounce, for: .seconds(0.3), scheduler: DispatchQueue.main)
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
