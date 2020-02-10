
import Foundation

class Statistic {
    var view = ""
    var like = ""
    
    init(dictionary: [String: Any]) {
        self.view = dictionary["viewCount"] as? String ?? ""
        self.like = dictionary["likeCount"] as? String ?? ""
    }
}

class StatisticRequest {
    var statistic: Statistic?
    
    init(dictionary: [String: Any]) {
        if let statisticDic = dictionary["statistics"] as? [String: Any] {
            self.statistic = Statistic(dictionary: statisticDic)
        }
    }
}
