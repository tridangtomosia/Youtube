
import Foundation

class TopComment {
    var topComment : CommentSnippet?
    
    init(dictionary: JSON) {
        if let dic = dictionary["topLevelComment"] as? JSON {
            self.topComment = CommentSnippet(dictionary: dic)
        }
    }
}
