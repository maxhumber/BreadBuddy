import SwiftUI

extension View {
    func lined() -> some View {
        self.modifier(Lined())
    }
}

fileprivate struct Lined: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 1) {
            content
            Rectangle()
                .frame(height: 1)
                .opacity(0.25)
        }
    }
}

struct View_lined_Previews: PreviewProvider {
    static var previews: some View {
        Text("Preview")
            .lined()
            .fixedSize()
    }
}
