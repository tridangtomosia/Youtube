
import UIKit

enum Method: String {
    case get
    case post
    case put
    case delete
}

enum APIError: Error {
    case json
    case network
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .json: return "JSON format has error"
        case .network: return "The network connection was lost"
        case .custom(let message): return message
        }
    }
}

enum APIResult {
    case success([String: Any])
    case failure(Error)
}

enum ServiceResult<T> {
    case success(T)
    case failure(APIError)
}

class ManagerAPI {
    static var shared = ManagerAPI()
    var dequeue = DispatchQueue(label: "API", qos: .background)
    
    func requestAPI(url: String, params: [String: String]?, method : Method , header: [String: String]?, completion: @escaping (APIResult) -> ()) {
        var urlQuery = ""
        if method == .get, let params = params {
            urlQuery = "?" + params.urlQuery()
        }
        guard let url = URL(string: (url + urlQuery)) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue.uppercased()
        if var header = header {
            header["Content-Type"] = "application/json"
            urlRequest.allHTTPHeaderFields = header
        } else {
            urlRequest.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        }
        
        if let params = params, method != .get {
            urlRequest.httpBody = try? JSONEncoder().encode(params)
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data, let dictionnary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                DispatchQueue.main.async {
                    completion(APIResult.success(dictionnary))
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(APIResult.failure(error))
                }
            }
        }
        dequeue.async {
            task.resume()
        }
    }
    
}
