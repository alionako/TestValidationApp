import SwiftValidator
import UIKit

// Helper protocol that all textfields should conform to

protocol Validatable {

    var validationDelegate: ValidationDelegate { get }
}

extension Validatable {

    func registerForValidation(field: UITextField & Validatable) {
        field.delegate = validationDelegate
    }

    func set(rules: [Rule]) {
        validationDelegate.set(rules: rules)
    }

    func set(textFieldRules: [TextFieldsRule]) {
        validationDelegate.set(textFieldRules: textFieldRules)
    }

}
