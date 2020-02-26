
import Foundation

class Comment {
    var commentModel : TopComment?
    
    init(dictionary: JSON) {
        if let dic = dictionary["snippet"] as? JSON {
            self.commentModel = TopComment(dictionary: dic)
        }
    }
    
    var name : String {
        return commentModel?.topComment?.commentSnippet?.name ?? ""
    }
    
    var avatar: String {
        return commentModel?.topComment?.commentSnippet?.avatar ?? ""
    }
    
    var comment : String {
        return commentModel?.topComment?.commentSnippet?.comment ?? ""
    }
    
    var time : String {
        return commentModel?.topComment?.commentSnippet?.time ?? ""
    }
    
    var likeCout : Int {
        return commentModel?.topComment?.commentSnippet?.likeCout ?? 0
    }
}
