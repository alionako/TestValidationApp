import UIKit
import SwiftValidator

// The class that will actually perform validation in the app
// Will have default settings that

typealias ValidationClosure = ((ValidationState) -> ())

final class ValidationDelegate: NSObject, UITextFieldDelegate {

    // Validation settings

    let validationTrigger: ValidationTrigger
    let isSynchronousValidation: Bool
    private (set) var rules: [Rule]
    private weak var field: UITextField?
    private let validationClosure: ValidationClosure
    private var currentText: String?

    private (set) var textFieldRules: [TextFieldsRule] {
        didSet { updateSubscriptions() }
    }

    private (set) var validationState: ValidationState = .unvalidated {
        didSet { validationClosure(validationState) }
    }

    init(validationTrigger: ValidationTrigger = .editingEnd,
         isSynchronousValidation: Bool = true,
         rules: [Rule] = [],
         textFieldRules: [TextFieldsRule] = [],
         validationClosure: @escaping ValidationClosure) { // Add all validation settings here

        self.validationTrigger = validationTrigger
        self.isSynchronousValidation = isSynchronousValidation
        self.rules = rules
        self.textFieldRules = textFieldRules
        self.validationClosure = validationClosure
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if validationTrigger != .enter {
            return true
        }

        let converted = textField.text as NSString?
        let newValue = converted?.replacingCharacters(in: range, with: string)
        guard let new = newValue else {
            return false
        }
        // check if validateOnEnter and process if needed
        return validate(string: new)
    }


    func textFieldDidEndEditing(_ textField: UITextField) {
        validateOnEditingEnd(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validateOnEditingEnd(textField)
    }

    @objc private func didChangeText() {
        guard let text = currentText, !text.isEmpty else {
            return
        }
        _ = validate(string: text)
    }
}

// MARK: - Public
extension ValidationDelegate {

    func set(rules: [Rule]) {
        self.rules = rules
    }

    func set(textFieldRules: [TextFieldsRule]) {
        self.textFieldRules = textFieldRules
    }
}
  
// MARK: - Private
private extension ValidationDelegate {

    func validate(string: String) -> Bool {
        validationState = .validating

        if string.isEmpty {
            validationState = .empty
            return true
        }

        let passesAllRules = rules.reduce(true, { $0 && $1.validate(string) })
        let passesAllTextFieldRules = textFieldRules.reduce(true, { $0 && $1.validate(string) })
        let isValid = passesAllRules && passesAllTextFieldRules

        validationState = isValid ? .valid : .invalid

        return isValid
    }

    private func validateOnEditingEnd(_ textField: UITextField) {
        guard validationTrigger == .editingEnd else {
            return
        }
        _ = validate(string: textField.text ?? "")
        currentText = textField.text ?? ""
    }

    func updateSubscriptions() {
        NotificationCenter.default.removeObserver(self)
        textFieldRules.forEach {
            $0.textFields.forEach { field in
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(didChangeText),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: nil)
            }
        }
    }
}
