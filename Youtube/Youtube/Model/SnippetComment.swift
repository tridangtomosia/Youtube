
import Foundation

class SnippetComment {
    var topLevelComment : CommentSnippet?
    
    init(dictionary: JSON) {
        if let dic = dictionary["topLevelComment"] as? JSON {
            self.topLevelComment = CommentSnippet(dictionary: dic)
        }
    }
}
