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
    public let store: StoreOf<MainFeature>
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: { tab in .tabSelected(tab)}
                )
            ) {
                Text("Home")
                    .tabItem(systemName: "house.fill", title: "Home")
                    .tag(FlowType.home)
                
                CoinSearchView(
                    store: store.scope(
                        state: \.coinSearchState,
                        action: \.coinSearch
                    )
                )
                .tabItem(systemName: "chart.line.uptrend.xyaxis", title: "Trending")
                .tag(FlowType.trend)
            }
        }
    }
}

