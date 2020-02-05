
import UIKit

class NetWorkLayer {
    
    let api = "https://www.googleapis.com/youtube/v3/"
    let googleKey = "AIzaSyAMbElh4mHvZpEzBsI_HweoPvSuvs6qvng"
    
    func getVideos(params: [String: String]?, completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "50"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0) }
                    completion?(.success(videos))
                } else {
                    
//                    completion?(ServiceResult.failure(<#T##Error#>))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func searchVideos(params: [String: String]?, completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "search"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "30"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0)}
                    completion?(.success(videos))
                } else {
                    
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func FindTrendVedeo(params: [String: String]? , completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videoCategories"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "30"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0)}
                    completion?(.success(videos))
                } else {
                    
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
