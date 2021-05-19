
import Foundation
import Combine
import MapKit

class StatisticsScreenViewModel: LoaderViewModel, ErrorableViewModel {
    internal let singleLocationRadius: CLLocationDistance = 500000
    internal var zoomToCountry: Bool = false
    
    var coordinator: StatisticsScreenCoordinatorDelegate?
    
    var repository: Covid19Repository
    
    var screenData = StatsDomainItem()
    
    var usecase: UseCaseSelection
    
    private var navigationInformation = NavigationInformation()
    var screenDataReady = PassthroughSubject<UseCaseSelection, Never>()
    var fetchScreenDataSubject = CurrentValueSubject<(usecase: UseCaseSelection,shouldShowLoader: Bool), Never>((usecase: UserDefaultsService.getUsecase(),shouldShowLoader: true))
    var loaderPublisher = PassthroughSubject<Bool, Never>()
    var errorSubject = PassthroughSubject<ErrorType?, Never>()
    
    init(repository: Covid19Repository) {
        self.repository = repository
        self.usecase = UserDefaultsService.getUsecase()
    }
    
    deinit { print("StatsScreenViewModel deinit called.") }
}

extension StatisticsScreenViewModel {
    func initializeFetchScreenDataSubject(_ subject: CurrentValueSubject<(usecase: UseCaseSelection,shouldShowLoader: Bool), Never>) -> AnyCancellable {
         return subject
            .flatMap { [unowned self] (usecase, shouldShowLoader) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                self.loaderPublisher.send(shouldShowLoader)
                switch usecase {
                case .country(let countryName):
                    return self.getCountryStatsResponse(for: countryName)
                case .worldwide:
                    return self.getWorldwideStatsResponse()
                }
            }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .sink { [unowned self] (response) in
            switch response {
            case .success(let newScreenData):
                self.screenData = newScreenData
                self.screenDataReady.send(usecase)
                errorSubject.send(nil)
            case .failure(let error):
                errorSubject.send(error)
            }
            loaderPublisher.send(false)
        }
    }
}

extension StatisticsScreenViewModel {
    func updateUsecase() {
        usecase = UserDefaultsService.getUsecase()
        fetchScreenDataSubject.send((usecase, true))
    }
    
    func annotationSelected(_ view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }
        
        switch usecase {
        case .country:
            openAppleMaps()
        case .worldwide:
            guard let countryName = annotation.title else {
                return
            }
            showCountryInformation(countryName)
        }
    }
    
    func annotationDeselected() {
        zoomToCountry = false
        switch usecase {
        case .worldwide:
            fetchScreenDataSubject.send((.worldwide, false))
        default:
            return
        }
    }
    
    func openAppleMaps() {
        let latitude: CLLocationDegrees = navigationInformation.latitude
        let longitude: CLLocationDegrees = navigationInformation.longitude
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: singleLocationRadius, longitudinalMeters: singleLocationRadius)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = navigationInformation.country
    
        coordinator?.openInAppleMaps(mapItem, showing: regionSpan)
    }
    
    func showCountryInformation(_ countryName: String) {
        zoomToCountry = true
        fetchScreenDataSubject.send((.country(countryName), false))
    }
    
    func openCountrySelection() { coordinator?.openCountrySelection() }
}

//MARK: - Private Methods
private extension StatisticsScreenViewModel {
    func createScreenData(from countryResponse: [CountryResponseItem]) -> StatsDomainItem {
        let real = countryResponse.filter({$0.province == ""})
        var tempScreenData = StatsDomainItem()
        tempScreenData.screenTitle = "Statistics by Country"
        guard let lastStats = real.last else { return tempScreenData }
        createNavigationInfromation(from: lastStats)
        tempScreenData.cardTitle = lastStats.country
        tempScreenData.confirmed = lastStats.confirmed
        tempScreenData.active = lastStats.active
        tempScreenData.recovered = lastStats.recovered
        tempScreenData.deceased = lastStats.deaths
        tempScreenData.centerLatitude = Double(lastStats.lat)
        tempScreenData.centerLongitude = Double(lastStats.lon)
        let annotation = createPointAnnotation(for: lastStats)
        tempScreenData.annotations.append(annotation)
        return tempScreenData
    }
    
    func createScreenData(from countries: [[CountryResponseItem]], and worldStats: WorldwideResponseItem) -> StatsDomainItem {
        var tempScreenData = StatsDomainItem()
        tempScreenData.screenTitle = "Statistics Worldwide"
        tempScreenData.cardTitle = "Worldwide"
        tempScreenData.confirmed = worldStats.global.totalConfirmed
        tempScreenData.recovered = worldStats.global.totalRecovered
        tempScreenData.deceased = worldStats.global.totalDeaths
        tempScreenData.active = worldStats.global.totalConfirmed - worldStats.global.totalRecovered
        
        for country in countries {
            guard let lastStats = country.last else { continue }
            let annotation = createPointAnnotation(for: lastStats)
            tempScreenData.annotations.append(annotation)
        }
        
        return tempScreenData
    }
    
    func createNavigationInfromation(from countryResponse: CountryResponseItem) {
        guard let latitude = Double(countryResponse.lat),
              let longitude = Double(countryResponse.lon) else {
            return
        }
        navigationInformation.country = countryResponse.country
        navigationInformation.latitude = latitude
        navigationInformation.longitude = longitude
    }
    
    func createPointAnnotation(for country: CountryResponseItem) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = country.country.lowercased()
        guard let latitude = Double(country.lat),
              let longitude = Double(country.lon) else {return MKPointAnnotation()}
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return annotation
    }
    
    func createSuccessPublisher(_ data: StatsDomainItem) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> {
        return Just<Result<StatsDomainItem, ErrorType>>(.success(data)).eraseToAnyPublisher()
    }
    
    func createFailurePublisher(_ error: ErrorType) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> {
        return Just<Result<StatsDomainItem, ErrorType>>(.failure(error)).eraseToAnyPublisher()
    }
    
    func getCountryStatsResponse(for countryName: String) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> {
        return repository.getCountryStats(for: countryName)
            .flatMap { [unowned self] (countryStatsResponse) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                switch countryStatsResponse {
                case .success(let data):
                    return createSuccessPublisher(self.createScreenData(from: data))
                case .failure(let error):
                    return self.createFailurePublisher(error)
                }
            }.eraseToAnyPublisher()
    }
    
    func getWorldwideStatsResponse() -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> {
        return repository.getWorldwideData()
            .flatMap { [unowned self] (response) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                switch response {
                case .success(let worldwideResponse):
                   let topThreeWorstCountries = worldwideResponse.countries
                    let worstCountry = repository.getCountryStats(for: topThreeWorstCountries[0].slug)
                    let secondWorstCountry = repository.getCountryStats(for: topThreeWorstCountries[1].slug)
                    let thirdWorstCountry = repository.getCountryStats(for: topThreeWorstCountries[2].slug)
                    #warning("MOCK WORLDWIDE RESPONSE, comment previous 4 lines, select worldiwde in county selection")
//                    let worstCountry = repository.getCountryStats(for: "spain")
//                    let secondWorstCountry = repository.getCountryStats(for: "portugal")
//                    let thirdWorstCountry = repository.getCountryStats(for: "croatia")
                    return Publishers.Zip3(worstCountry, secondWorstCountry, thirdWorstCountry)
                        .flatMap { (response1, response2, response3) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                            var country1 = [CountryResponseItem]()
                            var country2 = [CountryResponseItem]()
                            var country3 = [CountryResponseItem]()
                            switch response1 {
                            case .success(let data): country1 = data
                            case .failure(let error): print(error.localizedDescription); return self.createFailurePublisher(error)
                            }
            
                            switch response2 {
                            case .success(let data): country2 = data
                            case .failure(let error): print(error.localizedDescription); return self.createFailurePublisher(error)
                            }
            
                            switch response3 {
                            case .success(let data): country3 = data
                            case .failure(let error): print(error.localizedDescription); return self.createFailurePublisher(error)
                            }
                            let screenData = self.createScreenData(from: [country1, country2, country3], and: worldwideResponse)
                            return self.createSuccessPublisher(screenData)
                        }.eraseToAnyPublisher()
                    
                case .failure(let error):
                    return self.createFailurePublisher(error)
                }
            }.eraseToAnyPublisher()
    }
}
