import SwiftUI

extension View {
    func aligned() -> some View {
        self.modifier(Aligned())
    }
}

fileprivate struct Aligned: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Image(systemName: "square")
                .opacity(0)
            content
        }
        .contentShape(Rectangle())
    }
}


struct View_aligned_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                Image(systemName: "xmark")
                Image(systemName: "poweron")
            }
            HStack {
                Image(systemName: "xmark")
                    .aligned()
                Image(systemName: "poweron")
                    .aligned()
            }
        }
    }
}
