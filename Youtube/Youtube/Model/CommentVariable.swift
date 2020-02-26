
import Foundation

class CommentVariable {
    var authorDisplayName = ""
    var authorProfileImageUrl = ""
    var textDisplay = ""
    var updatedAt = ""
    var likeCout = 0
    
    init(dictionary: JSON) {
        self.authorDisplayName = dictionary["authorDisplayName"] as? String ?? ""
        self.authorProfileImageUrl = dictionary["authorProfileImageUrl"] as? String ?? ""
        self.textDisplay = dictionary["textDisplay"] as? String ?? ""
        self.updatedAt = dictionary["updatedAt"] as? String ?? ""
        self.likeCout = dictionary["likeCount"] as? Int ?? 0
    }
}
