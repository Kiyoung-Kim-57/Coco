//
//  MainFeature.swift
//  CocoPresent
//
//  Created by 김기영 on 8/26/25.
//
import ComposableArchitecture

public struct MainFeature: Reducer {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        var selectedTab: FlowType = .home
        var trendingSearchState = TrendingSearchFeature.State()
    }
    
    @CasePathable
    public enum Action {
        case tabSelected(FlowType)
        case trendingSearchAction(TrendingSearchFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .trendingSearchAction(let action):
                return .none
            }
        }
        
        Scope(state: \.trendingSearchState, action: \.trendingSearchAction) {
            TrendingSearchFeature()
        }
    }
}
