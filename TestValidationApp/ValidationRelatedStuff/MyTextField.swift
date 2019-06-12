import UIKit

// All textfields should conform to Validatable protocol
// to be supported by our validation framework

final class MyTextField: UITextField, Validatable {

    lazy var validationDelegate = ValidationDelegate(validationClosure: { [weak self] state in
        switch state {
        case .valid:
            self?.backgroundColor = .green
        case .invalid:
            self?.backgroundColor = .red
        case .validating:
            self?.backgroundColor = .blue
        case .empty:
            self?.backgroundColor = .white
        default:
            return
        }
    }) // delegate itself

    override init(frame: CGRect) {
        super.init(frame: frame)
        registerForValidation(field: self) // register for validation
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForValidation(field: self) // register for validation
    }

}
