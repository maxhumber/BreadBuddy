import SwiftUI

extension View {
    func underscore(infinity: Bool = false, hidden: Bool = false) -> some View {
        self.modifier(Underscore(infinity: infinity, hidden: hidden))
    }
}

fileprivate struct Underscore: ViewModifier {
    var infinity: Bool
    var hidden: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 1) {
            content
            Rectangle()
                .frame(height: 1)
                .opacity(hidden ? 0 : 0.25)
        }
        .fixedSize(horizontal: !infinity, vertical: true)
    }
}

struct View_Underline_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Preview")
                .underscore()
            Text("Preview")
                .underscore(hidden: true)
            Text("Preview")
                .underscore(infinity: true)
        }
    }
}
