
import Foundation

class Statistic : Codable {
    var view = ""
    var like = ""
    
    init(dictionary: JSON) {
        self.view = dictionary["viewCount"] as? String ?? ""
        self.like = dictionary["likeCount"] as? String ?? ""
    }
}

class StatisticRequest {
    var statistic: Statistic?
    
    init(dictionary: JSON) {
        if let statisticDic = dictionary["statistics"] as? JSON {
            self.statistic = Statistic(dictionary: statisticDic)
        }
    }
    
}
