//
//  ContentView.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI
import CocoDesign
import ComposableArchitecture

public struct MainView: View {
    @EnvironmentObject var appRouter: CocoAppRouter
    public let store: StoreOf<MainFeature>
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: { tab in MainFeature.Action.tabSelected(tab)}
                )
            ) {
                Text("Home")
                    .tabItem(systemName: "house.fill", title: "Home")
                    .tag(FlowType.home)
                
                TrendingCoinListView(
                    store: store.scope(
                        state: \.trendingSearchState,
                        action: \.trendingSearchAction
                    )
                )
                .tabItem(systemName: "chart.line.uptrend.xyaxis", title: "Trending")
                .tag(FlowType.trend)
            }
        }
    }
}

