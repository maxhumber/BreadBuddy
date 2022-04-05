import UIKit

extension UIApplication {
    func sendResignAction() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
