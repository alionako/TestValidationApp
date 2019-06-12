final class LessThanOrEqualToOtherTextField: TextFieldRule {

    override func validate(_ value: String) -> Bool {
        guard
            let comaprisonField = firstTextField?.text,
            let textFieldValue = ValidationNumberFormatter.number(from: value),
            let comparisonValue = ValidationNumberFormatter.number(from: comaprisonField) else {
            return false
        }
        return textFieldValue <= comparisonValue
    }
}
