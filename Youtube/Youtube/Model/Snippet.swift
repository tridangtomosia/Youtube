
import Foundation

class Snippet: Codable {
    var title = ""
    var nameChannel = ""
    var imageSize: ImageSize?
    
    init(dictionary: JSON) {
        self.title = dictionary["title"] as? String ?? ""
        self.nameChannel = dictionary["channelTitle"] as? String ?? ""
        if let highImageDic = dictionary["thumbnails"] as? JSON {
            self.imageSize = ImageSize(dictionary: highImageDic)
        }
    }
}
