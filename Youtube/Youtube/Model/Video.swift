
import UIKit

class Video {
    var id = ""
    var snippet : Snippet?
    var videoId : Identification?
    var statistic: Statistic?
    
    init(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        if let statisticDic = dictionary["statistics"] as? [String: Any] {
            self.statistic = Statistic(dictionary: statisticDic)
        }
        if let snippetDic =  dictionary["snippet"] as? [String: Any] {
            self.snippet = Snippet(dictionary: snippetDic)
        }
        if let idDic = dictionary["id"] as? [String: Any] {
            self.videoId = Identification(dictionary: idDic)
        }
    }
}


