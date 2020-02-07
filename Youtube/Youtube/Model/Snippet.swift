
import Foundation

class Snippet {
    var title = ""
    var nameChannel = ""
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.nameChannel = dictionary["channelTitle"] as? String ?? ""
    }
}
