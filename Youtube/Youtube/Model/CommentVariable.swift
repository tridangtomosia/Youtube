
import Foundation

class CommentVariable {
    var name = ""
    var avatar = ""
    var comment = ""
    var time = ""
    var likeCout = 0
    
    init(dictionary: JSON) {
        self.name = dictionary["authorDisplayName"] as? String ?? ""
        self.avatar = dictionary["authorProfileImageUrl"] as? String ?? ""
        self.comment = dictionary["textDisplay"] as? String ?? ""
        self.time = dictionary["updatedAt"] as? String ?? ""
        self.likeCout = dictionary["likeCount"] as? Int ?? 0
    }
}
