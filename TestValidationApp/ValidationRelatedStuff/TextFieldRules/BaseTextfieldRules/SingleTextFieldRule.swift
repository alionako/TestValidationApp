import SwiftValidator
import UIKit

// Base class for a group of rules that describe dependency between two textfields
class SingleTextFieldRule: TextFieldsRule {

    let textField: UITextField
    let message: String

    var textFields: [UITextField] {
        return [textField]
    }

    init(with textField: UITextField, message: String = "") {
        self.textField = textField
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
