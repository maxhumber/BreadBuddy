import Combine
import SwiftUI

class TextFieldAlertViewController: UIViewController {
    private let alertTitle: String
    private let message: String?
    @Binding private var text: String?
    private var isPresented: Binding<Bool>?
    private var cancellable: AnyCancellable?
    
    init(title: String, message: String?, text: Binding<String?>, isPresented: Binding<Bool>?) {
        self.alertTitle = title
        self.message = message
        self._text = text
        self.isPresented = isPresented
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAlertController()
    }
    
    private func presentAlertController() {
        guard cancellable == nil else { return }
        let vc = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        vc.addTextField { [weak self] textField in
            guard let self = self else { return }
            self.cancellable = NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: textField)
                .map { ($0.object as? UITextField)?.text }
                .assign(to: \.text, on: self)
        }
        let action = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.isPresented?.wrappedValue = false
        }
        vc.addAction(action)
        present(vc, animated: true, completion: nil)
    }
}

struct TextFieldAlert: UIViewControllerRepresentable {
    let title: String
    let message: String?
    @Binding var text: String?
    var isPresented: Binding<Bool>? = nil

    func makeUIViewController(context: Context) -> TextFieldAlertViewController {
        TextFieldAlertViewController(title: title, message: message, text: $text, isPresented: isPresented)
    }
    
    func updateUIViewController(_ uiViewController: TextFieldAlertViewController, context: Context) {}
    
    func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
        TextFieldAlert(title: title, message: message, text: $text, isPresented: isPresented)
    }
}

struct TextFieldWrapper: View {
    @Binding var isPresented: Bool
    let alert: () -> TextFieldAlert
    
    var body: some View {
        if isPresented {
            alert().dismissable($isPresented)
        } else {
            EmptyView()
        }
    }
}

struct TextFieldAlert2_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var alertIsPresented = false
        @State var text: String?
        
        var body: some View {
            ZStack {
                VStack {
                    Text("My Demo View")
                    Button {
                        alertIsPresented = true
                    } label: {
                        Text("Toggle Alert")
                    }
                }
                TextFieldWrapper(isPresented: $alertIsPresented) {
                    TextFieldAlert(title: "Hey", message: "Yo", text: $text, isPresented: $alertIsPresented)
                }
            }
        }
    }
}
