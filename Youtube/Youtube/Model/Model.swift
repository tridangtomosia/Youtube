
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
class Snippet {
    var title = ""
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
    }
}

class Video {
    var id = ""
    var snippet : Snippet?
    
    init(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        if let snippetDic =  dictionary["snippet"] as? [String: Any] {
            self.snippet = Snippet(dictionary: snippetDic)
        }
        
    }
}

class Chanel {
    var videoID = ""
    init(videoID: String) {
        self.videoID = videoID
    }
}

class Trend {
    
}
