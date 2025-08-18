import SwiftUI

public struct TabItemModifier: ViewModifier {
    let imageName: String
    let title: String
    let isSystemImage: Bool
    
    public func body(content: Content) -> some View {
        content
            .tabItem {
                if isSystemImage {
                    Label(title, systemImage: imageName)
                }
                else {
                    Label(title, image: imageName)
                }
            }
    }
}

public extension View {
    func tabItem(imageName: String, title: String) -> some View {
        return modifier(TabItemModifier(imageName: imageName, title: title, isSystemImage: false))
    }
    
    func tabItem(systemName: String, title: String) -> some View {
        return modifier(TabItemModifier(imageName: systemName, title: title, isSystemImage: true))
    }
}
