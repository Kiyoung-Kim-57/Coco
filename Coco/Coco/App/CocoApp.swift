//
//  CocoApp.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI
import SwiftData
import CocoDIContainer

@main
struct CocoApp: App {
    @StateObject private var appRouter = DIContainer.resolveAppRouter()
    
    init() {
        DIContainer.registerObjects()
    }
    
    var body: some Scene {
        WindowGroup {
            DIContainer.resolveMainView()
                .environmentObject(appRouter)
        }
    }
}
