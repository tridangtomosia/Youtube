
import UIKit

extension Dictionary where Key == String, Value == String {
    func urlQuery() -> String {
        return self.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"}.joined(separator: "&")
    }
}
