import SwiftUI

struct TabItemModifier: ViewModifier {
    let imageName: String
    let title: String
    let isSystemImage: Bool
    
    func body(content: Content) -> some View {
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

extension View {
    func tabItem(imageName: String, title: String, isSystemImage: Bool = false) -> some View {
        return modifier(TabItemModifier(imageName: imageName, title: title, isSystemImage: isSystemImage))
    }
}
