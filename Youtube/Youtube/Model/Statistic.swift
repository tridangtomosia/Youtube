
import Foundation

class InteractiveCount {
    var view = ""
    var like = ""
    init(dictionary: [String: Any]) {
        self.view = dictionary["viewCount"] as? String ?? ""
        self.like = dictionary["likeCount"] as? String ?? ""
    }
}

class Statistic {
    var statistic : InteractiveCount?
    init(dictionary : [String: Any]) {
        if let statisticDic = dictionary["statistics"] as? [String: Any] {
            self.statistic = InteractiveCount(dictionary: statisticDic)
        }
    }
}
