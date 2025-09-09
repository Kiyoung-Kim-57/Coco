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
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ZStack {
                    if !viewStore.searchListState.isSearching {
                        TrendingCoinListView(store: store.scope(state: \.trendingSearchState, action: \.trendingSearch))
                    }
                    SearchListView(store: store.scope(state: \.searchListState, action: \.searchList))
                }
            }
            .searchable(
                text: viewStore.binding(
                    get: \.searchText,
                    send: CoinSearchFeature.Action.searchTextChanged
                ), placement: .navigationBarDrawer(displayMode: .automatic)
            )
            .navigationTitle("Coin Search")
        }
    }
}
//
//#Preview {
//    CoinSearchView()
//}
