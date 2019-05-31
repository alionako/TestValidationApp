import UIKit

// The class that will actually perform validation in the app
// Will have default settings that

final class ValidationDelegate: NSObject, UITextFieldDelegate {

    // Validation settings

    let validateOnEnter: Bool
    let isServerValidation: Bool

    init(validateOnEnter: Bool = true,
         isServerValidation: Bool = true) { // Add all validation settings here

        self.validateOnEnter = validateOnEnter
        self.isServerValidation = isServerValidation
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // check if validateOnEnter and process if needed
        return true
    }
}