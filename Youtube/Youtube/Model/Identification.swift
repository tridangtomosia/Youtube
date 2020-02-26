
import Foundation

class Identification : Codable {
    var id = ""
    
    init(dictionary: JSON) {
        self.id = dictionary["videoId"] as? String ?? ""
    }
}
