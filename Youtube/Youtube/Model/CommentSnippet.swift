
import Foundation

class CommentSnippet {
    var snippet : CommentVariable?
    
    init(dictionary : JSON) {
        if let dic = dictionary["snippet"] as? JSON {
            self.snippet = CommentVariable(dictionary: dic)
        }
    }
}
