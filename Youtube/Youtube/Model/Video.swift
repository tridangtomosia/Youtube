
import UIKit

class Video: Codable {
    var id : String
    var snippet : Snippet?
    var videoId : Identification?
    var statistic: Statistic?
    var time: TimeInterval = 0
    
    init(dictionary: JSON) {
        self.id = dictionary["id"] as? String ?? ""
        if let statisticDic = dictionary["statistics"] as? JSON {
            self.statistic = Statistic(dictionary: statisticDic)
        }
        if let snippetDic =  dictionary["snippet"] as? JSON {
            self.snippet = Snippet(dictionary: snippetDic)
        }
        if let idDic = dictionary["id"] as? JSON {
            self.videoId = Identification(dictionary: idDic)
        }
    }
    
    var identification : String {
        if id == "" {
            return videoId?.id ?? ""
        } else {
            return id
        }
    }
    
    var nameChanel: String {
        return snippet?.nameChannel ?? ""
    }

    var nameVideo: String {
        return snippet?.title ?? ""
    }
    
    var viewCount: String {
        return statistic?.view ?? ""
    }
    
    var likeCount: String {
        return statistic?.like ?? ""
    }
    
    var imageAvatar: String {
        return snippet?.imageSize?.imageSizeDefault?.urlImage ?? ""
    }
    
    var imageMedium: String {
        return snippet?.imageSize?.imageSizeMedium?.urlImage ?? ""
    }
    
    var imageLarge: String {
        return snippet?.imageSize?.imageSizehigh?.urlImage ?? ""
    }
}
