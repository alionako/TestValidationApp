import Foundation

final class ValidationNumberFormatter {

    static func number(from string: String) -> Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: string)?.doubleValue
    }
}
