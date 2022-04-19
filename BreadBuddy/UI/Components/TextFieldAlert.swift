import SwiftUI
import UIKit

extension View {
    func alert(isPresented: Binding<Bool>, alert: () -> TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert(), content: self)
    }
}

struct TextAlert {
    var title: String
    var placeholder: String = ""
    var accept: String = "OK"
    var cancel: String = "Cancel"
    var action: (String?) -> ()
}

extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: nil, preferredStyle: .alert)
        addTextField { $0.placeholder = alert.placeholder }
        addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
            alert.action(nil)
        })
        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            alert.action(textField?.text)
        })
    }
}

fileprivate struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let hosting = UIHostingController(rootView: content)
        return hosting
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
    
    final class Coordinator {
        var alertController: UIAlertController?
        
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
}

struct TextFieldAlert_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var showsAlert = false
        var body: some View {
            VStack {
                Text("Hello, World!")
                Button("Alert") {
                    showsAlert = true
                }
                .alert(isPresented: $showsAlert) {
                    TextAlert(title: "Recipe URL", placeholder: "URL", accept: "Save") {
                        print("Callback \($0 ?? "<cancel>")")
                    }
                }
            }
        }
    }
}
