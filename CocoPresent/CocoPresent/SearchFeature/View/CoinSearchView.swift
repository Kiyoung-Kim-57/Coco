//
//  CoinSearchView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture

struct CoinSearchView: View {
    let store: StoreOf<CoinSearchFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    if viewStore.searchListState.searchResults.isEmpty {
                        TrendingCoinListView(store: store.scope(state: \.trendingSearchState, action: \.trendingSearch))
                    }
                    SearchListView(store: store.scope(state: \.searchListState, action: \.searchList))
                }
                .searchable(
                    text: Binding(
                        get: { viewStore.searchText },
                        set: { viewStore.send(.searchTextChanged($0)) }
                    ), placement: .navigationBarDrawer(displayMode: .always)
                )
            }
        }
    }
}
//
//#Preview {
//    CoinSearchView()
//}
