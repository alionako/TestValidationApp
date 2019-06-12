import UIKit
import SwiftValidator

// The class that will actually perform validation in the app
// Will have default settings that

final class ValidationDelegate: NSObject, UITextFieldDelegate {

    // Validation settings

    let validateOnEnter: Bool
    let isSynchronousValidation: Bool
    let rules: [Rule]
    let masterFields: [MasterField] // Fields will define content validation for current field

    init(validateOnEnter: Bool = true,
         isSynchronousValidation: Bool = true,
         rules: [Rule] = [],
         masterFields: [MasterField] = []) { // Add all validation settings here

        self.validateOnEnter = validateOnEnter
        self.isSynchronousValidation = isSynchronousValidation
        self.rules = rules
        self.masterFields = masterFields
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if !validateOnEnter {
            return true
        }

        let converted = textField.text as NSString?
        let newValue = converted?.replacingCharacters(in: range, with: string)
        guard let new = newValue else {
            return false
        }
        // check if validateOnEnter and process if needed
        return validateOnEnter && validate(string: new)
    }
}

private extension ValidationDelegate {

    func validate(string: String) -> Bool {
        let passesAllRules = rules.reduce(true, { $0 && $1.validate(string) })
        let passesAllTextFieldRules = masterFields.reduce(true, { $0 && $1.rule.validate(string) })
        return passesAllRules && passesAllTextFieldRules
    }
}
