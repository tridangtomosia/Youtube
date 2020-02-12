
import Foundation

class Statistic : Codable {
    var view = ""
    var like = ""
    var love = ""
    
    static var supportsSecureCoding: Bool {
        return false
    }
    
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
