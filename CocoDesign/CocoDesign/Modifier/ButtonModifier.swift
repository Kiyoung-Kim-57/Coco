//
//  ButtonModifier.swift
//  Coco
//
//  Created by 김기영 on 7/14/25.
//
import SwiftUI

public struct ButtonModifier: ViewModifier {
    
    let action: () -> ()
    let isDisabled: Bool
    
    public func body(content: Content) -> some View {
        Button {
            action()
        } label: {
            content
        }
        .disabled(isDisabled)
    }
}

public extension View {
    func asButton(_ action: @escaping () -> (), disabled: Bool = false) -> some View {
        modifier(ButtonModifier(action: action, isDisabled: disabled))
    }
}
