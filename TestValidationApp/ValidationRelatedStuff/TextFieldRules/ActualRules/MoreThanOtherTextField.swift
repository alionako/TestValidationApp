final class MoreThanOtherTextField: SingleTextFieldRule {

    override func validate(_ value: String) -> Bool {
        return true // TBD, actual rule with fromatter here
    }
}
