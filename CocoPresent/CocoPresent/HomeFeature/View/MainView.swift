//
//  ContentView.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI
import CocoDesign

public struct MainView: View {
    @EnvironmentObject var appRouter: CocoAppRouter
    
    public init() { }
    
    public var body: some View {
        TabView(selection: $appRouter.presentFlowType) {
            Text("Home")
                .tabItem(systemName: "house.fill", title: "home")
                .tag(FlowType.home)
        }
    }
}
