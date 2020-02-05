import UIKit

class BaseViewController: UIViewController {
    var homeVideos = [HomePage]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestAPI(key: String, params: [String: String])-> [HomePage] {
        ManagerAPI.shared.requestAPI(url: "https://www.googleapis.com/youtube/v3/"+key, params: params, method: .get, header: nil) { (APIResult) in
            switch APIResult {
            case .success(let dictionary):
                if let resultDictionary = dictionary["items"] as? [[String: Any]] {
                    let pages = resultDictionary.map { (dic) in
                        return HomePage(dictionary: dic)
                    }
                    self.homeVideos = pages
                }
                
            case .failure(_):
                print(1)
            }
        }
        return homeVideos
    }
}
