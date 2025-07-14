//
//  CocoApp.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI
import SwiftData

@main
struct CocoApp: App {
    @StateObjectInjection private var appRouter: CocoAppRouter
    
    init() {
        Self.registerDependency()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appRouter)
        }
    }
}

extension CocoApp {
    static func registerDependency() {
        DIContainer.shared.autoRegister([
            CocoFlowRouter<HomePresent>.self,
            CocoAppRouter.self
        ])
    }
}
