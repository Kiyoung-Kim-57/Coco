//
//  SearchListFeature.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import CocoDomain
import ComposableArchitecture

public struct SearchListFeature: Reducer {
    public init() { }
    
    public struct State: Equatable {
        var searchResults: CoinSearchListEntities = []
        var isSearching: Bool = false
        // TODO: Search Result Detail State
    }
    
    @CasePathable
    public enum Action {
        case searchResultFetched(CoinSearchListEntities)
        case searchCanceled
        // TODO: Search Result Detail Action
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .searchResultFetched(let results):
                state.isSearching = true
                state.searchResults = results
                return .none
            case .searchCanceled:
                state.isSearching = false
                state.searchResults = []
                return .none
            }
        }
    }
}

extension SearchListFeature {
    static var dummyData: [String] = [
        "Bit",
        "Cocoa",
        "Swift",
        "UIKit",
        "AppKit",
        "iOS",
        "macOS",
        "tvOS",
        "watchOS",
        "Objective-C",
        "Reactive",
    ]
}
