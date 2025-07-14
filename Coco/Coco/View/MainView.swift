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
        
        NavigationStack(path: $appRouter.mainFlowRouter.presentPath) {
            VStack {
                Button {
                    appRouter.presentView(type: MainPresent.self, to: .detail)
                } label: {
                    Text("Let's Go to Detail")
                }
            }
            .navigationDestination(for: MainPresent.self) { destination in
                switch destination {
                case .detail:
                    Text("It's Detail")
                case .main:
                    Text("It's Main")
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(DIContainer.shared.resolve(CocoAppRouter.self))
}
