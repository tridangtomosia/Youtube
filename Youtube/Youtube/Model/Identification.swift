
import Foundation

class Id {
    var id = ""
    init(dictionary: [String: Any]) {
        self.id = dictionary["videoId"] as? String ?? ""
    }
}
