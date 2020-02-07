
import UIKit

class NetWorkLayer {
    
    let api = "https://www.googleapis.com/youtube/v3/"
    let googleKey = "AIzaSyBWfw678OSge9ugRQbMnx4LQtPfcg_20AM"

    func getVideos(params: [String: String]?, completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "50"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet,statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0) }
                    completion?(.success(videos))
                } else {
                    completion?(.failure(APIError.json))
                }
            case .failure(let error):
                completion?(.failure(APIError.custom(error.localizedDescription)))
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
        parameter?["part"] = "snippet,statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0)}
                    completion?(.success(videos))
                } else {
                    completion?(.failure(APIError.json))
                }
            case .failure(let error):
                completion?(.failure(APIError.custom(error.localizedDescription)))
            }
        }
    }
    
    func findTrendVideo(params: [String: String]? , completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videoCategories"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "30"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet,statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
                    let videos = items.map { Video(dictionary: $0)}
                    completion?(.success(videos))
                } else {
                    completion?(.failure(APIError.json))
                }
            case .failure(let error):
                completion?(.failure(APIError.custom(error.localizedDescription)))
            }
        }
    }
}
