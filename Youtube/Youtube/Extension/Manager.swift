
import UIKit

enum Method: String {
    case get
    case post
    case put
    case delete
}

enum APIResult {
    case success([String: Any])
    case failure(Error)
}

enum ServiceResult<T> {
    case success(T)
    case failure(Error)
}

class ManagerAPI {
    static var shared = ManagerAPI()
    var dequeue = DispatchQueue(label: "API", qos: .background)
    
    func requestAPI(url: String, params: [String: String]?, method : Method , header: [String: String]?, completion: @escaping (APIResult) -> ()) {
        var tempURL = url
        if method == .get, let params = params {
            tempURL += "?" + params.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"}.joined(separator: "&")
        }
        guard let url = URL(string: tempURL) else { return }
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
                completion(APIResult.success(dictionnary))
            } else if let error = error {
                completion(APIResult.failure(error))
            }
        }
        dequeue.async {
            task.resume()
        }
    }
    
}
