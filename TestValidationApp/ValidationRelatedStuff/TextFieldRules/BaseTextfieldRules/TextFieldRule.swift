import SwiftValidator
import UIKit

// Base class for a group of rules that describe dependency between textfields
class TextFieldRule: TextFieldsRule {

    let message: String
    let textFields: [UITextField]

    var firstTextField: UITextField? {
        return textFields.first
    }

    init(with textFields: [UITextField], message: String = "") {
        self.textFields = textFields
        self.message = message
    }

    // Convenience init for single textField dependency
    convenience init(with textField: UITextField, message: String = "") {
        self.init(with: [textField], message: message)
    }

    // MARK - Override in subclasses

    func validate(_ value: String) -> Bool {
        fatalError("Define validation function in subclass")
    }

    func errorMessage() -> String {
        return message
    }
}
