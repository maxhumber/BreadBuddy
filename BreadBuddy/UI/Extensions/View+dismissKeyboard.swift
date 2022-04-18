import SwiftUI

extension View {
    func dismissKeyboard() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendResignAction()
        }
    }
}

fileprivate extension UIApplication {
    func sendResignAction() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
