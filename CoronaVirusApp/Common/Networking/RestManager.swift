//
//  RestManager.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

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
    
    public static func requestObservable<T: Codable>(url: String) -> AnyPublisher<Result<T, NetworkError>, Never> {
        return Future { promise in
            let request = RestManager.manager
                .request(url, encoding: URLEncoding.default)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        if let decodedObject: T = SerializationManager.parseData(jsonData: value) {
                            promise(.success(.success(decodedObject)))
                        } else {
                            promise(.success(.failure(.parseFailed)))
                        }
                    case .failure(let error):
                        guard let _ = error.underlyingError as? URLError else {
                            return promise(.success(.failure(.generalError)))
                        }
                        
                        return  promise(.success(.failure(.notConnectedToInternet)))
                    }
                }
            request.resume()
        }.eraseToAnyPublisher()
    }
}
