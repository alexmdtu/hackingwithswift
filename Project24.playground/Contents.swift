import UIKit

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        } else {
            return prefix + self
        }
    }
    
    func isNumeric() -> Bool {
        return Double(self) != nil
    }
    
    var lines: [Substring] {
        let array = self.split(separator: "\n")
        
        return array
    }
}

let test = "abcTest"
let firstTest = test.withPrefix("abc")
let test2 = "Test"
let secondTest = test2.withPrefix("abc")

let noNumerics = "abc"
let hasNumerics = "22.53"

let isNumericFalse = noNumerics.isNumeric()
let isNumericTrue = hasNumerics.isNumeric()

let fourLines = "this\nis\na\ntest"
let separated = fourLines.lines
