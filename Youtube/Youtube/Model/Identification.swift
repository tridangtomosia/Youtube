
import Foundation

class Identification : Codable {
    var id = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["videoId"] as? String ?? ""
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.setValue(id, forKey: "id")
    }

}
