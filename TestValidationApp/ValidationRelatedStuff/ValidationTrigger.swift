import Foundation

enum ValidationTrigger: Equatable {

    case enter
    case editingEnd
    case event(() -> ())

    static func == (lhs: ValidationTrigger, rhs: ValidationTrigger) -> Bool {
        switch (lhs, rhs) {

        case (.enter, .enter), (.editingEnd, .editingEnd), (.event(_), .event(_)):
            return true

        default:
            return false
        }
    }
}
