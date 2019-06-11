import SwiftValidator
import UIKit

// Base class for a group of rules that describe dependency between several textfields
class MultipleTextFieldsRule: TextFieldsRule {

    let textFields: [UITextField]
    let message: String

    init(with textFields: [UITextField], message: String = "") {
        self.textFields = textFields
        self.message = message
    }

    // MARK - Override in subclasses

    func validate(_ value: String) -> Bool {
        fatalError("Define validation function in subclass")
    }

    func errorMessage() -> String {
        return message
    }
}
