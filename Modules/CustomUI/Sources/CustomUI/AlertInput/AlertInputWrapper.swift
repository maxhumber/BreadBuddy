import SwiftUI

struct AlertInputWrapper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var alertInput: AlertInput
    
    func makeUIViewController(context: Context) -> AlertInputViewController {
        AlertInputViewController(isPresented: $isPresented, alertInput: alertInput)
    }
    
    func updateUIViewController(_ uiViewController: AlertInputViewController, context: Context) {}
}
