
import Foundation

typealias JSON = [String:Any]

class Image {
    var urlImage = ""
    init(dictionary: [String: Any]) {
        self.urlImage = dictionary["url"] as? String ?? ""
    }
}

class ImageSize {
    var imageSizeDefault : Image?
    var imageSizeMedium : Image?
    var imageSizehigh : Image?
    
    init(dictionary: JSON) {
        if let defaultSizes = dictionary["default"] as? JSON {
            self.imageSizeDefault = Image(dictionary: defaultSizes)
        }
        if let mediumSizes = dictionary["medium"] as? JSON {
            self.imageSizeMedium = Image(dictionary: mediumSizes)
        }
        if let highSizes = dictionary["high"] as? JSON {
            self.imageSizehigh = Image(dictionary: highSizes)
        }
    }
}
