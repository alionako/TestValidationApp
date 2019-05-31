import UIKit

// All textfields should conform to Validatable protocol
// to be supported by our validation framework

final class MyTextField: UITextField, Validatable {

    let validationDelegate = ValidationDelegate() // delegate itself

    override init(frame: CGRect) {
        super.init(frame: frame)
        registerForValidation(field: self) // register for validation
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForValidation(field: self) // register for validation
    }

}
