import SwiftValidator
import UIKit

// Helper protocol that all textfields should conform to

protocol Validatable {

    var validationDelegate: ValidationDelegate { get }
}

// MARK: - Validation settings

extension Validatable {

    func registerForValidation(field: UITextField & Validatable) {
        field.delegate = validationDelegate
    }

    func set(rules: [Rule]) {
        validationDelegate.set(rules: rules)
    }
}

// MARK: - Validation itself

extension Validatable {

    func validate(text: String?) {
        validationDelegate.validate(text: text ?? .emptyString)
    }
}


final class ValidationManager {

}
