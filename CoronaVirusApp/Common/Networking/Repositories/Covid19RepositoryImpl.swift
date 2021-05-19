import Foundation
import Combine

class Covid19RepositoryImpl: Covid19Repository {
    
    func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never> {
        let url = RestEndpoints.countriesList.endpoint()
        return RestManager.requestObservable(url: url)
    }

    func getCountryStatsTotal(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        let url = RestEndpoints.endpoint(.countryStatsTotal(countryName: countryName))()
        return RestManager.requestObservable(url:url)
    }

    func getCountryStats(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        let url = RestEndpoints.endpoint(.countryStats(countryName: countryName))()
        return RestManager.requestObservable(url:url)
    }

    func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never> {
        let url = RestEndpoints.endpoint(.worldwideStats)()
        let publisher: AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never> = RestManager.requestObservable(url:url).eraseToAnyPublisher()
        return publisher
            .flatMap { result -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never> in
                switch result {
                case .success(var response):
                    let filteredCountries = Array(response.countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed }).prefix(3))
                    response.countries = filteredCountries
                    return Just<Result<WorldwideResponseItem, ErrorType>>(.success(response)).eraseToAnyPublisher()
                case .failure(let error):
                    return Just<Result<WorldwideResponseItem, ErrorType>>(.failure(error)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
