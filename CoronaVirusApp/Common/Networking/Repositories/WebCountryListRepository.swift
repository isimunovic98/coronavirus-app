
import UIKit
import Combine

class WebCountryListRepository: Repository {

    func fetch<T: Codable>(from endpoint: String) -> AnyPublisher<Result<T, ErrorType>, Never> {
        return RestManager.requestObservable(url: endpoint)
    }
    
    func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never> {
        let endpoint = RestEndpoints.countriesList.toString()
        let publisher: AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>
        publisher = fetch(from: endpoint)
        return publisher
    }
}
