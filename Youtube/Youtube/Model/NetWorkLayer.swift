
import UIKit

class NetWorkLayer {
    
    let api = "https://www.googleapis.com/youtube/v3/"
    let googleKey = "AIzaSyBWfw678OSge9ugRQbMnx4LQtPfcg_20AM"
    
    func getStatistic(params: [String: String]?, completion: ((ServiceResult<InteractiveCount>)->())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["key"] = googleKey
        parameter?["part"] = "statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (results) in
            switch results {
            case .success(let data):
                if let items = data["items"] as? [String: Any] {
                    let statistics = InteractiveCount(dictionary: items)
                    completion?(.success(statistics))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func getStatisticDictionary(params: [String: String]?, completion: ((ServiceResult<[[String : Any]]>)->())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["key"] = googleKey
        parameter?["part"] = "statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (results) in
            switch results {
            case .success(let data):
                if let items = data["items"] as? [[String: Any]] {
//                    let statistics = items.map { Statistic(dictionary: $0) }
                    completion?(.success(items))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    
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
                    let videos = items.map { Video(dictionary: $0)
                    }
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
    
    func findTrendVideo(params: [String: String]? , completion: ((ServiceResult<[Video]>) -> ())?) {
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
