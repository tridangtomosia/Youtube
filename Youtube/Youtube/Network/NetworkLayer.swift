
import UIKit

class NetworkLayer {
    let api = "https://www.googleapis.com/youtube/v3/"
    let googleKey = "AIzaSyCTe4fz2A4NwzfWdAupTqGIMiLlvRTt_3I"
    
    func getVideos(params: [String: String]?,
                   completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "50"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet,statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get,
                                     header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [JSON] {
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
    
    func searchVideos(params: [String: String]?, withNumberOfFind number: Int,
                      completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "search"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = String(number)
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get,
                                     header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [JSON] {
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
    
    func getStatistic(params: [String: String]?, id: String,
                      completion: ((ServiceResult<[StatisticRequest]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["id"] = id
        parameter?["key"] = googleKey
        parameter?["part"] = "statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get,
                                     header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [JSON] {
                    let statistic = items.map { StatisticRequest(dictionary: $0)}
                    completion?(.success(statistic))
                } else {
                    completion?(.failure(APIError.json))
                }
            case .failure(let error):
                completion?(.failure(APIError.custom(error.localizedDescription)))
            }
        }
    }
    
    func getTrendVideo(params: [String: String]? ,
                       completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "50"
        parameter?["key"] = googleKey
        parameter?["chart"] = "mostpopular"
        parameter?["part"] = "snippet,statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get,
                                     header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [JSON] {
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
    
    func getComment(params: [String: String]? ,
                    completion: ((ServiceResult<[Comment]>)->())?) {
        let url = api + "commentThreads"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "20"
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get,
                                     header: nil) { (result) in
            switch result {
            case .success(let data):
                if let items = data["items"] as? [JSON] {
                    let comments = items.map { Comment(dictionary: $0)}
                    completion?(.success(comments))
                } else {
                    completion?(.failure(APIError.json))
                }
            case .failure(let error):
                completion?(.failure(APIError.custom(error.localizedDescription)))
            }
        }
    }
}
