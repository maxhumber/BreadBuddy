import SwiftUI

struct TextAlert3 {
    var title: String
    var message: String?
    @Binding var text: String
    var completion: () -> ()
}

class TextFieldAlert3ViewController: UIViewController, UITextFieldDelegate {
    let alertTitle: String
    let message: String
    var text: Binding<String>
    var isPresented: Binding<Bool>
    let completion: () -> Void
    
    var acceptAction: UIAlertAction!
    
    init(alertTitle: String, message: String, text: Binding<String>, isPresented: Binding<Bool>, completion: @escaping () -> Void) {
        self.alertTitle = alertTitle
        self.message = message
        self.text = text
        self.isPresented = isPresented
        self.completion = completion
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
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.delegate = self
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.isPresented.wrappedValue = false
        }
        alertController.addAction(cancelAction)
        acceptAction = UIAlertAction(title: "Accept", style: .default) { _ in
            self.isPresented.wrappedValue = false
            self.completion()
        }
        acceptAction.isEnabled = false
        alertController.addAction(acceptAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var proposedText = textField.text!
        proposedText.replaceSubrange(Range(range, in: textField.text!)!, with: string)
        acceptAction.isEnabled = proposedText.isEmpty == false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newText = textField.text else { fatalError("Unexpected state") }
        text.wrappedValue = newText
    }
}

struct TextFieldAlert3Wrapper: UIViewControllerRepresentable {
    let alertTitle: String
    let message: String
    @Binding var text: String
    @Binding var isPresented: Bool
    let completion: () -> Void
    
    func makeUIViewController(context: Context) -> TextFieldAlert3ViewController {
        TextFieldAlert3ViewController(alertTitle: alertTitle, message: message, text: $text, isPresented: $isPresented, completion: completion)
    }
    
    func updateUIViewController(_ alertController: TextFieldAlert3ViewController, context: Context) {}
}


// MARK: - View Extension

extension View {
    func alert(title: String, message: String, text: Binding<String>, isPresented: Binding<Bool>, completion: @escaping () -> Void) -> some View {
        ZStack {
            if isPresented.wrappedValue {
                TextFieldAlert3Wrapper(alertTitle: title, message: message, text: text, isPresented: isPresented, completion: completion)
            }
            self
        }
    }
}

struct TextFieldAlert3_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var alertIsPresented = false
        @State var text: String = ""
        
        var body: some View {
            VStack {
                Text(text)
                Text("My Demo View")
                Button {
                    alertIsPresented = true
                } label: {
                    Text("Toggle Alert")
                }
            }
            .alert(title: "Alert 3", message: "Sup", text: $text, isPresented: $alertIsPresented, completion: {})
        }
    }
}
