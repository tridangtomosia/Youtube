
import Foundation

class Snippet {
    var title = ""
    var nameChannel = ""
    var imageSize: ImageSize?
    
    var imageSizeDefault : String {
        return imageSize?.imageSizeDefault?.urlImage ?? ""
    }
    var imageSizeMedium : String {
        return imageSize?.imageSizeMedium?.urlImage ?? ""
    }
    var imageSizeHigh : String {
        return imageSize?.imageSizehigh?.urlImage ?? ""
    }
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.nameChannel = dictionary["channelTitle"] as? String ?? ""
        if let highImageDic = dictionary["thumbnails"] as? [String: Any] {
            self.imageSize = ImageSize(dictionary: highImageDic)
        }
    }
}
