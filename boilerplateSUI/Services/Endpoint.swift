import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents(string: AppConfig.baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
    
    var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppConfig.Keys.apiKey)"
        ]
    }
} 