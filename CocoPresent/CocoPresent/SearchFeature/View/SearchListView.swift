//
//  SearchListView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture
import CocoDesign

struct SearchListView: View {
    let store: StoreOf<SearchListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if !viewStore.searchResults.isEmpty {
               searchListView(viewStore)
            } else {
                EmptyView()
            }
        }
    }
    
    private func searchListView(_ viewStore: ViewStore<SearchListFeature.State, SearchListFeature.Action>) -> some View {
        List(viewStore.searchResults, id: \.self) { item  in
            SearchListCell(item)
        }
        .listStyle(.plain)
    }
}


//
//#Preview {
//    SearchListView()
//}
