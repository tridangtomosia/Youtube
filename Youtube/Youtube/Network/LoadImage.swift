
import UIKit

class LoadImage {
    static var shared = LoadImage()
    var memory = [String: UIImage]()
    var dequere = DispatchQueue(label: "LoadImage", qos: .unspecified)
    
    func downLoad (urlString: String, completion: @escaping (UIImage?)->()) {
        if let image = memory[urlString] {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            dequere.async {
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        self.memory[urlString] = image
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                }
            }
        }
    }
}
