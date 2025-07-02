//
//  ContentView.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainRouter: CocoStackRouter = CocoStackRouter(pathType: MainPresent.self)
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    MainView()
}
