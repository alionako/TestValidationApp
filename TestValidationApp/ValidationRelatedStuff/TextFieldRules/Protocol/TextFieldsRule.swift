import SwiftValidator
import UIKit

protocol TextFieldsRule: Rule {
    var textFields: [UITextField] { get }
    var message: String { get }
}
