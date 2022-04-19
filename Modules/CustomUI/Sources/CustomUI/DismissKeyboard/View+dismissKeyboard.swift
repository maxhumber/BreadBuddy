import SwiftUI

extension View {
    public func dismissKeyboard() -> some View {
        self.contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}
