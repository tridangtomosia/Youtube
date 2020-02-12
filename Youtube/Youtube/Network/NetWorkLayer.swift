
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
    
    func searchVideos(params: [String: String]?, withNumberOfFind number: Int, completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "search"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = String(number)
        parameter?["key"] = googleKey
        parameter?["part"] = "snippet"
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
    
    func getStatistic(params: [String: String]?, id: String, completion: ((ServiceResult<[StatisticRequest]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["id"] = id
        parameter?["key"] = googleKey
        parameter?["part"] = "statistics"
        ManagerAPI.shared.requestAPI(url: url, params: parameter, method: .get, header: nil) { (result) in
            switch result {
                case .success(let data):
                    if let items = data["items"] as? [[String: Any]] {
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
    
    func getTrendVideo(params: [String: String]? , completion: ((ServiceResult<[Video]>) -> ())?) {
        let url = api + "videos"
        var parameter = params
        if params == nil {
            parameter = [:]
        }
        parameter?["maxResults"] = "50"
        parameter?["key"] = googleKey
        parameter?["chart"] = "mostpopular"
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
}
