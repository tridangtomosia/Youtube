
import Foundation

class Identification {
    var id = ""
    init(dictionary: [String: Any]) {
        self.id = dictionary["videoId"] as? String ?? ""
    }
}
