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
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.isLoading {
                    ProgressView()
                } else {
                    topTenCoinListContainer(viewStore)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func topTenCoinListContainer(
        _ viewStore: ViewStore<TrendingSearchFeature.State, TrendingSearchFeature.Action>
    ) -> some View {
        VStack(spacing: 0) {
            trendListHeaderView(viewStore)
            coinListScrollView(viewStore.coinList)
                .padding(.horizontal, 8)
        }
    }
    
    private func coinListScrollView(_ coins: [TrendingCoinListEntity]) -> some View {
        ScrollView {
            Section {
                ForEach(coins, id: \.name) { item in
                    TrendingCoinListCell(item)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, minHeight: Constants.cellMinHeight)
                }
            }
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
        .fadeOverlay()
    }
    
    private func trendListHeaderView(
        _ viewStore: ViewStore<TrendingSearchFeature.State, TrendingSearchFeature.Action>
    ) -> some View {
        HStack(alignment: .bottom) {
            CocoLabel(
                "Trending Coins",
                font: HeaderFont.titleFont
            )
            .padding(12)
            Spacer()
            CocoLabel(
                viewStore.searchDate + " 기준",
                font: HeaderFont.dateFont,
                textColor: HeaderFont.dateColor
            )
            .padding(12)
        }
    }
}

extension TrendingCoinListView {
    enum Constants {
        static let contentPadding = EdgeInsets(
            top: 0,
            leading: 10,
            bottom: 10,
            trailing: 0
        )
        
        static let cellMinHeight: CGFloat = 50
    }
    
    enum HeaderFont {
        static let titleFont = Font.system(size: 20, weight: .heavy)
        static let dateFont = Font.system(size: 14)
        static let dateColor = CocoColor.resource(.gray70)
    }
}
