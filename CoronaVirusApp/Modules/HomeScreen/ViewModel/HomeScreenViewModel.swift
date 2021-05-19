
import UIKit
import Combine
import CoreLocation

class HomeScreenViewModel: ErrorableViewModel, LoaderViewModel {
    
    var coordinator: HomeScreenCoordinatorImpl?
    weak var viewControllerDelegate: HomeScreenViewController?
    var repository: Covid19Repository
    var screenData = HomeScreenDomainItem()
    var loaderPublisher = PassthroughSubject<Bool, Never>()
    var errorSubject = PassthroughSubject<ErrorType?, Never>()
    var updateScreenSubject = PassthroughSubject<Bool, Never>()
    var fetchScreenDataSubject = PassthroughSubject<Void, Never>()
    var shouldRemoveLoader = false
    
    init(repository: Covid19Repository) {
        self.repository = repository
    }
    deinit { print("HomeScreenViewModel deinit called.") }
}

extension HomeScreenViewModel {
    
    func handleLocation(using locationManager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            switch  CLLocationManager.authorizationStatus() {
            case .denied, .restricted:
                shouldRemoveLoader = true
                fetchScreenDataSubject.send()
            case .notDetermined:
                shouldRemoveLoader = false
                locationManager.requestWhenInUseAuthorization()
            default:
                shouldRemoveLoader = false
                locationManager.startUpdatingLocation()
            }
        }
        else {
            handleError(.noInternet)
        }
    }
    
    func getData() {
        guard let savedUsecase = UserDefaultsService.getUsecase()
        else {
            getDefaultData()
            return
        }
        self.usecase = savedUsecase
        fetchScreenDataSubject.send()
    }
    
    func getDefaultData() {
        self.usecase = .country("croatia")
        fetchScreenDataSubject.send()
    }
    
    func changeUsecaseSelection() { coordinator?.openCountrySelection() }
    
    func initializeFetchScreenDataSubject(_ subject: AnyPublisher<Void, Never>) -> AnyCancellable {
        subject
            .flatMap { [unowned self] (_) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                self.loaderPublisher.send(true)
                return self.getData(UserDefaultsService.getUsecase())
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [unowned self] (result) in
                self.handleResult(result)
                if shouldRemoveLoader {
                    self.loaderPublisher.send(false)
                }
            }
    }
    
    func getData(_ usecase: UseCaseSelection?) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> {
        guard let usecase = usecase else { return createFailurePublisher(.general) }
        switch usecase {
        case .country(let countryName): return getCountryData(name: countryName)
        case .worldwide: return getWorldwideData()
        }
    }
    
    func getCountryData(name countryName: String) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> {
        return Publishers.Zip(getTotalCountryStatsPublisher(name: countryName),
                              getDayOneCountryStatsPublisher(name: countryName))
            .flatMap { (totalResponse, dayOneResponse ) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                var totalData = [CountryResponseItem]()
                var dayOneData = [CountryResponseItem]()
                switch totalResponse {
                case .success(let data): totalData = data
                case .failure(let error): return self.createFailurePublisher(error)
                }
                switch dayOneResponse {
                case .success(let data): dayOneData = data
                case .failure(let error): return self.createFailurePublisher(error)
                }
                let newScreenData = self.createScreenData(from: totalData, and: dayOneData)
                return self.createSuccessPublisher(newScreenData)
            }.eraseToAnyPublisher()
    }
    func getDayOneCountryStatsPublisher(name: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        return repository.getCountryStats(for: name)
    }
    func getTotalCountryStatsPublisher(name: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        return repository.getCountryStats(for: name)
    }
    func getWorldwideData() -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> {
        return repository.getWorldwideData()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .flatMap { (result) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                switch result {
                case .success(let worldwideResponse):
                    let newScreenData: HomeScreenDomainItem = self.createScreenData(from: worldwideResponse)
                    return self.createSuccessPublisher(newScreenData)
                case .failure(let error):
                    return self.createFailurePublisher(error)
                }
            }.eraseToAnyPublisher()
    }
    
    func handleResult(_ result: Result<HomeScreenDomainItem, ErrorType>) {
        switch result {
        case .success(let item):
            screenData = item
            if screenData.title.isEmpty {
                switch UserDefaultsService.getUsecase() {
                case .country(let countryName): screenData.title = countryName
                case .worldwide: screenData.title = "Worldwide"
                default: break
                }
            }
            else {
                UserDefaultsService.update(createUserDefaultsDomainItem(from: item))
                handleError(nil)
            }
            updateScreenSubject.send(true)
        case .failure(let error):
            handleError(error)
        }
    }
    
    
    func createScreenData(from totalStats: [CountryResponseItem], and dayOneStats: [CountryResponseItem]) -> HomeScreenDomainItem {
        var screenData = HomeScreenDomainItem()
        if totalStats.count > 2,
           dayOneStats.count > 2 {
            let dayOneStatsLast = dayOneStats[dayOneStats.count - 2]    // skip today data (same data on api for today and yesterday)
            let totalLast = totalStats[totalStats.count - 2]            // skip today data (same data on api for today and yesterday)
            let dayOneStatsSecondToLast = dayOneStats[dayOneStats.count - 3]
            screenData.title = totalLast.country
            screenData.confirmedTotalCount = totalLast.confirmed
            screenData.confirmedDifferenceCount = dayOneStatsLast.confirmed - dayOneStatsSecondToLast.confirmed
            screenData.activeTotalCount = totalLast.active
            screenData.activeDifferenceCount = dayOneStatsLast.active - dayOneStatsSecondToLast.active
            screenData.recoveredTotalCount = totalLast.recovered
            screenData.recoveredDifferenceCount = dayOneStatsLast.recovered - dayOneStatsSecondToLast.recovered
            screenData.deathsTotalCount = totalLast.deaths
            screenData.deathsDifferenceCount = dayOneStatsLast.deaths - dayOneStatsSecondToLast.deaths
            screenData.details = createDetails(from: dayOneStats).reversed()
            screenData.lastUpdateDate = Date()
        }
        return screenData
    }
    
    func createScreenData(from item: WorldwideResponseItem) -> HomeScreenDomainItem {
        var screenData = HomeScreenDomainItem()
        screenData.title = "Worldwide"
        screenData.confirmedTotalCount = item.global.totalConfirmed
        screenData.confirmedDifferenceCount = item.global.newConfirmed
        screenData.recoveredTotalCount = item.global.totalRecovered
        screenData.recoveredDifferenceCount = item.global.newRecovered
        screenData.deathsTotalCount = item.global.totalDeaths
        screenData.deathsDifferenceCount = item.global.newDeaths
        screenData.activeTotalCount = screenData.confirmedTotalCount - screenData.recoveredTotalCount
        screenData.activeDifferenceCount = screenData.confirmedDifferenceCount - screenData.recoveredDifferenceCount
        screenData.details = createDetailsTop3WithConfirmedCases(from: item.countries)
        screenData.lastUpdateDate = Date()
        return screenData
    }
    
    func createDetailsTop3WithConfirmedCases(from items: [CountryStatus]) -> [HomeScreenDomainItemDetail] {
        let filteredItems = Array(items.sorted(by: { $0.totalConfirmed > $1.totalConfirmed }).prefix(3))
        return createDetails(from: filteredItems)
    }
    
    func createDetails(from responseItems: [CountryResponseItem]) -> [HomeScreenDomainItemDetail] {
        var newDetails = [HomeScreenDomainItemDetail]()
        #warning("using less items from api! Optimisation needed.")
        for (index, responseItem) in responseItems.suffix(1000).enumerated() {
            if index == 0 {
                var item = HomeScreenDomainItemDetail()
                item.title = DateUtils.getDomainDetailItemDate(from: responseItem.date) ?? ""
                item.confirmed = responseItem.confirmed
                item.recovered = responseItem.recovered
                item.deaths = responseItem.deaths
                item.active = responseItem.active
                newDetails.append(item)
            } else if index != responseItems.count - 1 {  // skip today data (same data on api for today and yesterday)
                let previousResponseItem = responseItems[index - 1]
                var item = HomeScreenDomainItemDetail()
                item.title = DateUtils.getDomainDetailItemDate(from: responseItem.date) ?? ""
                item.confirmed = responseItem.confirmed - previousResponseItem.confirmed
                item.recovered = responseItem.recovered - previousResponseItem.recovered
                item.deaths = responseItem.deaths - previousResponseItem.deaths
                item.active = responseItem.active - previousResponseItem.active
                newDetails.append(item)
            }
        }
        return newDetails
    }
    
    func createDetails(from responseItems: [CountryStatus]) -> [HomeScreenDomainItemDetail] {
        var newDetails = [HomeScreenDomainItemDetail]()
        for responseItem in responseItems {
            var item = HomeScreenDomainItemDetail()
            item.title = responseItem.countryName
            item.confirmed = responseItem.totalConfirmed
            item.recovered = responseItem.totalRecovered
            item.deaths = responseItem.totalDeaths
            item.active = responseItem.totalConfirmed - responseItem.totalRecovered
            newDetails.append(item)
        }
        return newDetails
    }
    
    func createUserDefaultsDomainItem(from value: HomeScreenDomainItem) -> UserDefaultsDomainItem {
        switch value.title {
        case "Worldwide":
            return UserDefaultsDomainItem(usecase: value.title, details: value.details.map({ $0.title}))
        default:
            return UserDefaultsDomainItem(usecase: value.title, details: [value.title])
        }
    }
    
    func createSuccessPublisher(_ data: HomeScreenDomainItem) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> {
        return Just<Result<HomeScreenDomainItem, ErrorType>>(.success(data)).eraseToAnyPublisher()
    }
    
    func createFailurePublisher(_ error: ErrorType) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> {
        return Just<Result<HomeScreenDomainItem, ErrorType>>(.failure(error)).eraseToAnyPublisher()
    }
}

extension HomeScreenViewModel: CountrySelectionHandler {
    func openCountrySelection() { coordinator?.openCountrySelection() }
}

extension HomeScreenViewModel {
    func didUpdateLocations(_ locations: [CLLocation]) {
        if let location = locations.last {
            CLGeocoder().reverseGeocodeLocation(location) { [unowned self] placemarks, error in
                guard let country: String = placemarks?.first?.country,
                      error == nil else { return }
                let slug = StringUtils.createSlug(from: country)
                let item = UserDefaultsDomainItem(usecase: slug, details: .init())
                UserDefaultsService.update(item)
                shouldRemoveLoader = true
                fetchScreenDataSubject.send()
            }
        }
    }
    
    func didChangeAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            shouldRemoveLoader = true
            viewControllerDelegate?.locationManager.startUpdatingLocation()
        default:
            fetchScreenDataSubject.send()
        }
    }
}
