import Foundation
import Alamofire
import Combine

public class RestManager {
    private static let manager: Alamofire.Session = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 50
        configuration.timeoutIntervalForResource = 50
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
    
    static func requestObservable<T: Codable>(url: String) -> AnyPublisher<Result<T, ErrorType>, Never> {
        return Future<Result<T, ErrorType>, Never> { promise in
            AF.request(url)
                .validate(statusCode: 200..<423)
                .response(completionHandler: { (response) in
                    if let responseError = response.error,
                       let error: URLError = responseError.underlyingError as? URLError {
                        switch error.code {
                        case .timedOut, .notConnectedToInternet, .networkConnectionLost:
                            promise(.success(.failure(.noInternet)))
                        default: break
                        }
                    }
                })
                .responseData { (response) in
                    if let data = response.data,
                       let parsedData: T = SerializationManager.parseData(jsonData: data) {
                            promise(.success(.success(parsedData)))
                        }
                    promise(.success(.failure(.general)))
                }
        }.eraseToAnyPublisher()
    }
}
