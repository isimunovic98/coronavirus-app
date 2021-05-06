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
        return RestManager.requestObservable(url:url)
    }
}
