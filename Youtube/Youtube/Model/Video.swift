
import UIKit

class Video {
    var id = ""
    var snippet : Snippet?
    var videoId : Id?
    var image : ImageSize?
    var statistic: Statistic?
    init(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.statistic = Statistic(dictionary: dictionary)
        
        if let snippetDic =  dictionary["snippet"] as? [String: Any] {
            self.snippet = Snippet(dictionary: snippetDic)
        }
        if let idDic = dictionary["id"] as? [String: Any] {
            self.videoId = Id(dictionary: idDic)
        }
        if let imageDic = dictionary["thumbnails"] as? [String: Any] {
            self.image = ImageSize(dictionary: imageDic)
        }

    }
}


