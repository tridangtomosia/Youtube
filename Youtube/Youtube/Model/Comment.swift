
import Foundation

class Comment {
    var snippet : SnippetComment?
    
    init(dictionary: JSON) {
        if let dic = dictionary["snippet"] as? JSON {
            self.snippet = SnippetComment(dictionary: dic)
        }
    }
    
    var name : String {
        return snippet?.topLevelComment?.snippet?.authorDisplayName ?? ""
    }
    
    var avatar: String {
        return snippet?.topLevelComment?.snippet?.authorProfileImageUrl ?? ""
    }
    
    var comment : String {
        return snippet?.topLevelComment?.snippet?.textDisplay ?? ""
    }
    
    var time : String {
        return snippet?.topLevelComment?.snippet?.updatedAt ?? ""
    }
    
    var likeCout : Int {
        return snippet?.topLevelComment?.snippet?.likeCout ?? 0
    }
}
