
import Foundation

class CommentSnippet {
    var commentSnippet : CommentVariable?
    
    init(dictionary : JSON) {
        if let dic = dictionary["snippet"] as? JSON {
            self.commentSnippet = CommentVariable(dictionary: dic)
        }
    }
}
