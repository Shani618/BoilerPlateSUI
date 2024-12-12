import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidResponse }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                
                guard 200...299 ~= response.statusCode else {
                    return Fail(error: NetworkError.serverError("Status code: \(response.statusCode)"))
                        .eraseToAnyPublisher()
                }
                
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in NetworkError.decodingError }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
} 