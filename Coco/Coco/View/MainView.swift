//
//  ContentView.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appRouter: CocoAppRouter
    
    var body: some View {
        TabView(selection: $appRouter.presentFlowType) {
            Text("Home")
                .tabItem(imageName: "house.fill", title: "home", isSystemImage: true)
                .tag(FlowType.home)
        }
    }
}
