import UIKit

// The class that will actually perform validation in the app
// Will have default settings that

final class ValidationDelegate: NSObject, UITextFieldDelegate {

    // Validation settings

    let validateOnEnter: Bool
    let isSynchronousValidation: Bool
    let masterFields: [MasterField] // Fields will define content validation for current field

    init(validateOnEnter: Bool = true,
         isSynchronousValidation: Bool = true,
         masterFields: [MasterField] = []) { // Add all validation settings here

        self.validateOnEnter = validateOnEnter
        self.isSynchronousValidation = isSynchronousValidation
        self.masterFields = masterFields
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // check if validateOnEnter and process if needed
        return true
    }
}
