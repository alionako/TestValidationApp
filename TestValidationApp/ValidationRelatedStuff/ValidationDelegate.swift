import UIKit
import SwiftValidator

// The class that will actually perform validation in the app
// Will have default settings that

typealias ValidationClosure = ((String?) -> Result<Bool, Error>)
typealias ValidationStateHandler = ((ValidationState) -> ())

class ValidationDelegate: NSObject, UITextFieldDelegate {

    // Validation settings

    private (set) var rules: [Rule]
    private (set) var validationStateHandler: ValidationStateHandler
    private (set) var validationClosure: ValidationClosure?
    private (set) var validationTrigger: ValidationTrigger
    private var currentText: String?
    private weak var field: UITextField?

    private (set) var textFieldRules: [TextFieldsRule] {
        didSet { updateSubscriptions() }
    }

    private (set) var validationState: ValidationState = .unvalidated {
        didSet { validationStateHandler(validationState) }
    }

    init(validationTrigger: ValidationTrigger = .editingEnd,
         validationClosure: ValidationClosure? = nil,
         rules: [Rule] = [],
         textFieldRules: [TextFieldsRule] = [],
         validationStateHandler: @escaping ValidationStateHandler) { // Add all validation settings here

        self.validationTrigger = validationTrigger
        self.validationClosure = validationClosure
        self.rules = rules
        self.textFieldRules = textFieldRules
        self.validationStateHandler = validationStateHandler
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
        return validate(string: new) ?? false
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
        validate(text: text)
    }

    // MARK: - Public: ValidationDelegate configuration

    func set(rules: [Rule]) {
        self.rules = rules
    }

    func set(textFieldRules: [TextFieldsRule]) {
        self.textFieldRules = textFieldRules
    }

    func set(validationTrigger: ValidationTrigger) {
        self.validationTrigger = validationTrigger
    }

    func set(validationClosure: @escaping ValidationClosure) {
        self.validationClosure = validationClosure
    }

    // MARK: - Public: validation

    func validate(text: String?) {
        _ = validate(string: text ?? .emptyString)
    }
}

// MARK: - Private
private extension ValidationDelegate {

    func validate(string: String) -> Bool? {
        validationState = .validating

        let rulesValidationPassed = rules.reduce(true, { $0 && $1.validate(string) })
        guard rulesValidationPassed, let result = validationClosure?(string) else {
            validationState = rulesValidationPassed ? .valid : .invalid
            return rulesValidationPassed
        }

        switch result {
        case .success(let isValid):
            validationState = isValid ? .valid : .invalid
            return isValid
        case .failure:
            validationState = .failedToValidate
            return nil
        }
    }

    private func validateOnEditingEnd(_ textField: UITextField) {
        guard validationTrigger == .editingEnd else {
            return
        }
        currentText = textField.text ?? .emptyString
        validate(text: currentText)
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



//final class FormManager {
//    var fields: [UITextField]
//}
//
//
//final class FieldRule {
//
//    var rule: Rule
//    var parentRules: [Rule]
//    var childRules: [Rule]
//}
