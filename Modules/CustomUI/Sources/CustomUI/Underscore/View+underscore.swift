import SwiftUI

extension View {
    public func underscore(infinity: Bool = false, hidden: Bool = false) -> some View {
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
                .opacity(hidden ? 0 : 1)
        }
        .fixedSize(horizontal: !infinity, vertical: true)
    }
}

struct View_Underscore_Previews: PreviewProvider {
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
