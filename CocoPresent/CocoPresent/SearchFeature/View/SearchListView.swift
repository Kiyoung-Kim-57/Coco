//
//  SearchListView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture

struct SearchListView: View {
    let store: StoreOf<SearchListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if !viewStore.searchResults.isEmpty {
                List(viewStore.searchResults, id: \.self) { item  in
                    Text(item)
                }
                .listStyle(.plain)
            } else {
                EmptyView()
            }
        }
    }
}

//
//#Preview {
//    SearchListView()
//}
