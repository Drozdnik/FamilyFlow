import SwiftUI

struct ScrollContentBackground: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(color)
    }
}

extension View {
    func scrollContentBackground(_ color: Color) -> some View {
        self.modifier(ScrollContentBackground(color: color))
    }
}
