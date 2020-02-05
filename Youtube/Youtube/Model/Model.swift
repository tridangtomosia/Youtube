
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

class HomePage {
    var idVideo = ""
    var nameChanel = ""
    var dic = [String: Any]()
    init(dictionary: [String:Any]) {
        self.idVideo = dictionary["id"] as? String ?? ""
        self.dic = dictionary["snippet"] as? [String: Any] ?? ["":""]
        self.nameChanel = dic["title"] as? String ?? ""
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
