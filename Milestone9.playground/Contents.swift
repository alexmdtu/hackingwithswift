import UIKit

extension UIView {
    func bounceOut(duration: Double) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

extension Int {
    func times(block: () -> Void) {
        guard self > 0 else { return }
        for _ in 1...self {
            block()
        }
    }
}

extension Array where Element: Comparable{
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}

let view = UIView()
view.bounceOut(duration: 3)

4.times {
    print("hello!")
}

var testArray = [1, 2, 3, 4, 4, 5, 6]
testArray.remove(item: 4)
