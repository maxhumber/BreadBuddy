import SwiftUI
import UIKit

class AlertInputViewController: UIViewController, UITextFieldDelegate {
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
