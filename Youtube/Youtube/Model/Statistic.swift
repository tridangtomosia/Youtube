
import Foundation

class Statistic {
    var view = ""
    var like = ""
    init(dictionary: [String: Any]) {
        self.view = dictionary["viewCount"] as? String ?? ""
        self.like = dictionary["likeCount"] as? String ?? ""
    }
}
