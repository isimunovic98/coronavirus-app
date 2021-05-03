//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 02.04.2021..
//

import Foundation
import Combine

class CountrySelectionViewModel: LoaderViewModel {
    
    private let repository: Covid19Repository
    
    var coordinatorDelegate: CoordinatorDelegate?
    
    var screenData = [CountrySelectionModel]()
    private var countriesList = [Country]()
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    let searchPublisher = PassthroughSubject<String, Never>()
    var loaderPublisher = PassthroughSubject<Bool, Never>()
    
    init(repository: Covid19Repository) {
        self.repository = repository
    }
    
    deinit {
        print("CountrySelection VM deinit")
    }
}

extension CountrySelectionViewModel {
    func initializeScreenData(with subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject
            .flatMap({ [unowned self] shouldShowLoader -> AnyPublisher<Result<[Country], NetworkError>, Never> in
                self.loaderPublisher.send(shouldShowLoader)
                return self.repository.getCountriesList()
            })
            .map({ [unowned self] (result) -> Result<[CountrySelectionModel], NetworkError> in
                switch result {
                case .success(let data):
                    self.countriesList = self.setupInitialData(with: data)
                    return .success(self.createScreenData(from: self.countriesList))
                case .failure(let error):
                return .failure(error)
                }
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.screenData = data
                    self.dataReadyPublisher.send()
                    self.loaderPublisher.send(false)
                case .failure(let error):
                    print(error.localizedDescription)
                    #warning("send error and show screen acordingly")
                }
            })
    }
    
    func attachFilterListener(subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] (filterString) -> [CountrySelectionModel] in
                let filteredList = filter(self.countriesList, with: filterString)
                return self.createScreenData(from: filteredList)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [unowned self] data in
                self.screenData = data
                self.dataReadyPublisher.send()
        }
   }
}

extension CountrySelectionViewModel {
    private func createScreenData(from data: [Country]) -> [CountrySelectionModel] {
        var temporaryScreenData = [CountrySelectionModel]()
        
        temporaryScreenData.append(CountrySelectionModel(content: "Worldwide", cellType: .worldwide))
        
        if data.isEmpty {
            temporaryScreenData.append(CountrySelectionModel(content: "No results found", cellType: .emptyState))
            return temporaryScreenData
        } else {
            for country in data {
                temporaryScreenData.append(CountrySelectionModel(country: country))
            }
            return temporaryScreenData
        }
        
    }
    
    private func setupInitialData(with data: [Country]) -> [Country] {
        let sortedCountriesList = data.sorted { $0.country < $1.country }
        return sortedCountriesList
    }
    
    private func filter(_ list: [Country], with filter: String) -> [Country] {
        if filter.isEmpty {
            return list
        } else {
            let filteredCountriesList = list.filter {$0.country.lowercased().contains(filter.lowercased())}
            return filteredCountriesList
        }
    }
    
    func update(_ selectedCountry: String) {
        let item = UserDefaultsDomainItem(usecase: selectedCountry.lowercased(), details: [])
        UserDefaultsService.update(item)
    }
}
