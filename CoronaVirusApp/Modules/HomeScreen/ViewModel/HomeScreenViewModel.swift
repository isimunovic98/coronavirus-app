
import UIKit
import Combine
import CoreLocation

class HomeScreenViewModel: ErrorableViewModel, LoaderViewModel {
    
    var coordinator: HomeScreenCoordinatorImpl?
    weak var viewControllerDelegate: HomeScreenViewController?
    var repository: Covid19Repository
    var screenData = HomeScreenDomainItem()
    var usecase: UseCaseSelection?
    var loaderPublisher = PassthroughSubject<Bool, Never>()
    var errorSubject = PassthroughSubject<ErrorType?, Never>()
    var updateScreenSubject = PassthroughSubject<Void, Never>()
    var fetchScreenDataSubject = PassthroughSubject<Void, Never>()
    var loaderIsVisible = false
    init(repository: Covid19Repository) {
        self.repository = repository
    }
    deinit { print("HomeScreenViewModel deinit called.") }
    
}

extension HomeScreenViewModel {
    
    func getData() {
        if let savedUsecase = UserDefaultsService.getUsecase() {
            usecase = savedUsecase
            fetchScreenDataSubject.send()
        } else {
            checkLocationServices()
        }
    }
    
    func changeUsecaseSelection() { coordinator?.openCountrySelection() }
    
    func initializeFetchScreenDataSubject(_ subject: AnyPublisher<Void, Never>) -> AnyCancellable {
        subject
            .flatMap { [unowned self] (_) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                guard let usecase = self.usecase else { return self.createFailurePublisher(.general) }
                if !loaderIsVisible { loaderPublisher.send(true) }
                switch usecase {
                case .country(let countryName):
                    let dayOneStatsPublisher: AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> = repository.getCountryStats(for: countryName)
                    let totalStatsPublisher: AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> = repository.getCountryStatsTotal(for: countryName)
                    return Publishers.Zip(totalStatsPublisher, dayOneStatsPublisher)
                        .flatMap { (totalResponse, dayOneResponse ) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                            var totalData = [CountryResponseItem]()
                            var dayOneData = [CountryResponseItem]()
                            switch totalResponse {
                            case .success(let data):
                                if data.isEmpty { return self.createFailurePublisher(.general) }
                                totalData = data
                            case .failure(let error):
                                return self.createFailurePublisher(error)
                            }
                            switch dayOneResponse {
                            case .success(let data):
                                if data.isEmpty { return self.createFailurePublisher(.general) }
                                dayOneData = data
                            case .failure(let error):
                                return self.createFailurePublisher(error)
                            }
                            let newScreenData = createScreenData(from: totalData, and: dayOneData)
                            return self.createSuccessPublisher(newScreenData)
                        }.eraseToAnyPublisher()
                case .worldwide:
                    return repository.getWorldwideData()
                        .flatMap { (result) -> AnyPublisher<Result<HomeScreenDomainItem, ErrorType>, Never> in
                            switch result {
                            case .success(let worldwideResponse):
                                let newScreenData: HomeScreenDomainItem = createScreenData(from: worldwideResponse)
                                return self.createSuccessPublisher(newScreenData)
                            case .failure(let error):
                                return self.createFailurePublisher(error)
                            }
                        }.eraseToAnyPublisher()
                }
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [unowned self] (result) in
                switch result {
                case .success(let item):
                    self.screenData = item
                    UserDefaultsService.update(self.createUserDefaultsDomainItem(from: item))
                    self.updateScreenSubject.send()
                case .failure(let error):
                    errorSubject.send(error)
                }
                loaderIsVisible = false
                loaderPublisher.send(false)
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
        for (index, responseItem) in responseItems.enumerated() {
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
        return UserDefaultsDomainItem(usecase: value.title,
                                      details: value.details.map({ $0.title }))
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
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(),
           let manager = viewControllerDelegate?.locationManager {
            manager.delegate = viewControllerDelegate
            manager.desiredAccuracy = kCLLocationAccuracyBest
            switch manager.authorizationStatus {
            case .denied, .restricted, .notDetermined: manager.requestWhenInUseAuthorization()
            default: manager.startUpdatingLocation()
            }
        }
    }
    
    func didUpdateLocations(_ locations: [CLLocation]) {
        if let location = locations.last {
            CLGeocoder().reverseGeocodeLocation(location) { [unowned self] placemarks, error in
                guard let country: String = placemarks?.first?.country,
                      error == nil else { return }
                let slug = country.lowercased().replacingOccurrences(of: " ", with: "-")
                self.usecase = .country(slug)
                self.fetchScreenDataSubject.send()
            }
        }
    }
    
    func didChangeAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            viewControllerDelegate?.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
                usecase = .country("croatia")
                fetchScreenDataSubject.send()
        default:
            viewControllerDelegate?.locationManager.startUpdatingLocation()
        }
    }
}
