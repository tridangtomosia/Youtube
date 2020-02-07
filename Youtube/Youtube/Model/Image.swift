
import Foundation


class Image {
    var avatar = ""
    init(dictionary: [String: Any]) {
        self.avatar = dictionary["url"] as? String ?? ""
    }
}

class ImageSize {
    var imageSizeDefault : Image?
    init(dictionary: [String: Any]) {
        if let imageSizes = dictionary["default"] as? [String:Any] {
            self.imageSizeDefault = Image(dictionary: imageSizes)
        }
    }
}
