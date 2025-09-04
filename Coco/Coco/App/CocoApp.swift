//
//  CocoApp.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI
import SwiftData
import CocoDIContainer
import CocoPresent
import ComposableArchitecture

@main
struct CocoApp: App {
    init() {
        DIContainer.registerObjects()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(store: Store(initialState: MainFeature.State()) {
                MainFeature()
            })
        }
    }
}
