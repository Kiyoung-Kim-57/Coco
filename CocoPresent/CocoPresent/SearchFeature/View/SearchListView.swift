//
//  SearchListView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/4/25.
//

import SwiftUI
import CocoDesign
import ComposableArchitecture

struct SearchListView: View {
    let store: StoreOf<SearchListFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if viewStore.isSearching {
                if viewStore.searchResults.isEmpty {
                    noResultsView()
                } else {
                    searchListView(viewStore)
                }
            } else {
                EmptyView()
            }
        }
    }

    private func searchListView(
        _ viewStore: ViewStore<
            SearchListFeature.State, SearchListFeature.Action
        >
    ) -> some View {
        List(viewStore.searchResults, id: \.self) { item in
            SearchListCell(item)
        }
        .listStyle(.plain)
    }

    private func noResultsView() -> some View {
        CocoLabel(
            "No Results",
            font: PrimaryFont.font,
            textColor: PrimaryFont.color
        )
    }
}

extension SearchListView {
    enum PrimaryFont {
        static let font: Font = Font.system(size: 20, weight: .regular)
        static let color: Color = CocoColor.resource(.gray70)
    }
}

//
//#Preview {
//    SearchListView()
//}
