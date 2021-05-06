
import UIKit
import Combine

class WebWorldwideStatsRepository: Repository {
    
    func fetch<T: Codable>(from endpoint: String) -> AnyPublisher<Result<T, ErrorType>, Never> {
        return RestManager.requestObservable(url: endpoint)
    }
    
    func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never> {
        let url = RestEndpoints.toString(.worldwideStatus)()
        let publisher: AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>
        publisher = fetch(from: url)
        return publisher
    }
}
