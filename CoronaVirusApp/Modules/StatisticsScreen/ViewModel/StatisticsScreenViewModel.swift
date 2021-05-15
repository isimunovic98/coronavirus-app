
import Foundation
import Combine
import MapKit

class StatisticsScreenViewModel: LoaderViewModel, ErrorableViewModel {
    internal let singleLocationRadius: CLLocationDistance = 500000
    internal var zoomToCountry: Bool = false

    var coordinator: StatisticsScreenCoordinator?
    
    var repository: Covid19Repository
    
    var screenData = StatsDomainItem()
    
    var usecase: UseCaseSelection?
    
    private var navigationInformation = NavigationInformation()
    var screenDataReady = PassthroughSubject<UseCaseSelection, Never>()
    var fetchScreenDataSubject = PassthroughSubject<UseCaseSelection, Never>()
    var loaderPublisher = PassthroughSubject<Bool, Never>()
    var errorSubject = PassthroughSubject<ErrorType?, Never>()
    
    init(repository: Covid19Repository) {
        self.repository = repository
        guard let usecase = UserDefaultsService.getUsecase() else {
            self.usecase = .country("croatia")
            return
        }
        self.usecase = usecase
    }
    
    deinit { print("StatsScreenViewModel deinit called.") }
}

extension StatisticsScreenViewModel {
    func initializeFetchScreenDataSubject(_ subject: PassthroughSubject<UseCaseSelection, Never>) -> AnyCancellable {
        return subject.flatMap { [unowned self] (usecase) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
            loaderPublisher.send(true)
            switch usecase {
            case .country(let countryName):
                return repository.getCountryStats(for: countryName)
                    .flatMap { (totalResponse) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                        switch totalResponse {
                        case .success(let data): return self.createSuccessPublisher(self.createScreenData(from: data))
                        case .failure(let error): return self.createFailurePublisher(error)
                        }
                    }.eraseToAnyPublisher()
            case .worldwide:
                if let savedData = UserDefaultsService.getSavedData(),
                   savedData.details.count == 3 {
                    let p1 = repository.getCountryStats(for: savedData.details[0])
                    let p2 = repository.getCountryStats(for: savedData.details[1])
                    let p3 = repository.getCountryStats(for: savedData.details[2])
                    let p4 = repository.getWorldwideData()
                    return Publishers.Zip4(p1, p2, p3, p4)
                        .flatMap { (totalResponse1,totalResponse2,totalResponse3,worldwideResponse) -> AnyPublisher<Result<StatsDomainItem, ErrorType>, Never> in
                            var totalData1 = [CountryResponseItem]()
                            var totalData2 = [CountryResponseItem]()
                            var totalData3 = [CountryResponseItem]()
                            var worldwideData: WorldwideResponseItem
                            
                            switch totalResponse1 {
                            case .success(let data): totalData1 = data
                            case .failure(let error): return self.createFailurePublisher(error)
                            }
                            
                            switch totalResponse2 {
                            case .success(let data): totalData2 = data
                            case .failure(let error): return self.createFailurePublisher(error)
                            }
                            
                            switch totalResponse3 {
                            case .success(let data): totalData3 = data
                            case .failure(let error): return self.createFailurePublisher(error)
                            }
                            
                            switch worldwideResponse {
                            case .success(let data): worldwideData = data
                            case .failure(let error): return self.createFailurePublisher(error)
                            }
                            let newScreenData = self.createScreenData(from: [totalData1, totalData2, totalData3], and: worldwideData)
                            return self.createSuccessPublisher(newScreenData)
                        }.eraseToAnyPublisher()
                    
                }
                else { return self.createFailurePublisher(.general) }
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .sink { [unowned self] (response) in
            switch response {
            case .success(let newScreenData):
                self.screenData = newScreenData
                if let usecase = self.usecase {
                    self.screenDataReady.send(usecase)
                }
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
        guard let updatedUsecase = usecase else { return }
        fetchScreenDataSubject.send(updatedUsecase)
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
        default:
            break
        }
    }
    
    func openAppleMaps() {
        let latitude: CLLocationDegrees = navigationInformation.latitude
        let longitude: CLLocationDegrees = navigationInformation.longitude
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: singleLocationRadius, longitudinalMeters: singleLocationRadius)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = navigationInformation.country
        mapItem.openInMaps(launchOptions: options)
    }
    
    func showCountryInformation(_ countryName: String) {
        zoomToCountry = true
        fetchScreenDataSubject.send(.country(countryName))
    }
    
    func annotationDeselected() {
        zoomToCountry = false
        switch usecase {
        case .worldwide:
            fetchScreenDataSubject.send(.worldwide)
        default:
            return
        }
    }
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
    
    func createNavigationInfromation(from countryResponse: CountryResponseItem) {
        guard let latitude = Double(countryResponse.lat),
              let longitude = Double(countryResponse.lon) else {
            return
        }
        navigationInformation.country = countryResponse.country
        navigationInformation.latitude = latitude
        navigationInformation.longitude = longitude
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
}
