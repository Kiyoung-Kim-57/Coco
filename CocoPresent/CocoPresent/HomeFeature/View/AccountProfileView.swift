//
//  AccountProfileView.swift
//  Coco
//
//  Created by 김기영 on 8/15/25.
//

import SwiftUI
import CocoDesign

public struct AccountProfileView: View {
    
    public init() { }
    
    public var body: some View {
        CocoContainer(shadowType: .strong) {
            VStack {
                CocoLabel("ITs a Account Profile View")
            }
        }
    }
}

#Preview {
    AccountProfileView()
}
