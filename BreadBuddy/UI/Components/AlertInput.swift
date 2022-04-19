import SwiftUI

extension View {
    func alert(isPresented: Binding<Bool>, alertInput: () -> AlertInput) -> some View {
        ZStack {
            if isPresented.wrappedValue {
                AlertInputWrapper(isPresented: isPresented, alertInput: alertInput())
                    .fixedSize()
            }
            self
        }
    }
}

struct AlertInput {
    var title: String
    var message: String? = nil
    var placeholder: String = ""
    @Binding var text: String?
}

fileprivate class AlertInputViewController: UIViewController, UITextFieldDelegate {
    var isPresented: Binding<Bool>
    var alertInput: AlertInput
    
    init(isPresented: Binding<Bool>, alertInput: AlertInput) {
        self.isPresented = isPresented
        self.alertInput = alertInput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentAlert()
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: alertInput.title, message: alertInput.message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.alertInput.text
            textField.placeholder = self.alertInput.placeholder
            textField.delegate = self
        }
        let action = UIAlertAction(title: "Save", style: .default) { _ in
            self.isPresented.wrappedValue = false
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var proposedText = textField.text!
        proposedText.replaceSubrange(Range(range, in: textField.text!)!, with: string)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newText = textField.text else { fatalError("Unexpected state") }
        alertInput.$text.wrappedValue = newText
    }
}

fileprivate struct AlertInputWrapper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var alertInput: AlertInput
    
    func makeUIViewController(context: Context) -> AlertInputViewController {
        AlertInputViewController(isPresented: $isPresented, alertInput: alertInput)
    }
    
    func updateUIViewController(_ uiViewController: AlertInputViewController, context: Context) {}
}

struct AlertInput_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var alertIsPresented = false
        @State var text: String? = ""
        
        var body: some View {
            VStack {
                Text(text ?? "Nothing")
                Text("My Demo View")
                Button {
                    alertIsPresented = true
                } label: {
                    Text("Toggle Alert")
                }
            }
            .alert(isPresented: $alertIsPresented) {
                AlertInput(title: "hey", placeholder: "Hi", text: $text)
            }
        }
    }
}
