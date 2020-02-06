
import UIKit

class User {
    var name = ""
    var identification = ""
    var email = ""
    init(name: String, identification: String, email: String) {
        self.name = name
        self.identification = identification
        self.email = email
    }
}

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

class Snippet {
    var title = ""
    var nameChannel = ""
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.nameChannel = dictionary["channelTitle"] as? String ?? ""
    }
}

class Id {
    var id = ""
    init(dictionary: [String: Any]) {
        self.id = dictionary["videoId"] as? String ?? ""
    }
}

class Image {
    var avatar = ""
    init(dictionary: [String: Any]) {
        self.avatar = dictionary["url"] as? String ?? ""
    }
}

class ImageSize {
    var imageSizeDefault : Image?
    init(dictionary: [String: Any]) {
        if let imageSizes = dictionary["default"] as? [String:Any] {
            self.imageSizeDefault = Image(dictionary: imageSizes)
        }
    }
}

class Video {
    var id = ""
    var snippet : Snippet?
    var videoId : Id?
    var image : ImageSize?
    var statistic: Statistic?
    init(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        if let snippetDic =  dictionary["snippet"] as? [String: Any] {
            self.snippet = Snippet(dictionary: snippetDic)
        }
        if let idDic = dictionary["id"] as? [String: Any] {
            self.videoId = Id(dictionary: idDic)
        }
        if let avatarDic = dictionary["thumbnails"] as? [String: Any] {
            self.image = ImageSize(dictionary: avatarDic)
        }
//        if let statisticDic = dictionary["statistics"] as? [String: Any] {
            self.statistic = Statistic(dictionary: dictionary)
//        }
    }
}


//class SearchVideo {
//    var snippet : Snippet?
//    var videoId : Id?
//    init(dictionary: [String: Any]) {
//        if let snippetDic =  dictionary["snippet"] as? [String: Any] {
//            self.snippet = Snippet(dictionary: snippetDic)
//        }
//        if let idDic = dictionary["id"] as? [String: Any] {
//            self.videoId = Id(dictionary: idDic)
//        }
//    }
//}

