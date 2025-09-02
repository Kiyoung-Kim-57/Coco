//
//  FadeModifier.swift
//  CocoDesign
//
//  Created by 김기영 on 9/2/25.
//

import SwiftUI

public struct FadeModifier: ViewModifier {
    
    let topFade: Bool
    let bottomFade: Bool
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if topFade {
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0.8), .white.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 30)
                        .allowsHitTesting(false)
                    } else {
                        Spacer()
                            .frame(height: 50)
                    }
                    Spacer()
                    if bottomFade {
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 30)
                        .allowsHitTesting(false)
                    }
                }
            )
    }
}

public extension View {
    func fadeOverlay(topFade: Bool = true, bottomFade: Bool = true) -> some View {
        modifier(FadeModifier(topFade: topFade, bottomFade: bottomFade))
    }
}
