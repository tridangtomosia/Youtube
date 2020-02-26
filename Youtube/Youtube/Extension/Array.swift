
import Foundation

extension Array where Element == String {
    func comportId() -> String {
        return self.joined(separator: ",")
    }
}

