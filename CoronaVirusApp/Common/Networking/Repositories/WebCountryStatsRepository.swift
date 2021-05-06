
import UIKit
import Combine

class WebCountryStatsRepository: Repository {
    
    func fetch<T: Codable>(from endpoint: String) -> AnyPublisher<Result<T, ErrorType>, Never> {
        return RestManager.requestObservable(url: endpoint)
    }
    
    func getCountryData(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        #warning("EEEEEEEE")
        let url = RestEndpoints.toString(.countryStatus(countryName: "mexico"))()
        var publisher: AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>
        publisher = fetch(from: url)
        return publisher
    }
}
