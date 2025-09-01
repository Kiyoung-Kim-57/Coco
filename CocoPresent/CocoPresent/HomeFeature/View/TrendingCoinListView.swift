//
//  AccountProfileView.swift
//  Coco
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI
import CocoDesign
import CocoDomain
import ComposableArchitecture

public struct TrendingCoinListView: View {
    let store: StoreOf<TrendingSearchFeature>
    
    public init(store: StoreOf<TrendingSearchFeature>) {
        print("View Init")
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                coinListScrollView(viewStore.coinList)
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
            }
            .onAppear {
                print("On Appear")
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func coinListScrollView(_ coins: [TrendingCoinListEntity]) -> some View {
        ScrollView {
            ForEach(coins, id: \.name) { item in
                TrendingCoinListCell(item)
                    .padding(.horizontal, 10)
            }
        }
    }
}
