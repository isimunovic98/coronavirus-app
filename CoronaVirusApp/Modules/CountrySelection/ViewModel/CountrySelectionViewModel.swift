//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 02.04.2021..
//

import Foundation
import Combine

class CountrySelectionViewModel {
    private let repository: Covid19Repository
    
    var coordinatorDelegate: CoordinatorDelegate?
    
    var screenData = [Country]()
    private var countriesList = [Country]()
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    let searchPublisher = PassthroughSubject<String, Never>()
    
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
                #warning("show loader screen")
                return self.repository.getCountriesList()
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.createScreenData(from: data)
                    self.dataReadyPublisher.send()
                    #warning("remove loader screen")
                case .failure(let error):
                    print(error.localizedDescription)
                    #warning("send error and show screen acordingly")
                }
            })
    }
    
    func attachFilterListener(subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        return subject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [unowned self] filer in
                self.screenData = self.filter(self.countriesList, with: filer)
                self.dataReadyPublisher.send()
        }
   }
}

extension CountrySelectionViewModel {
    private func createScreenData(from data: [Country]) {
        let sortedCountriesList = data.sorted { $0.country < $1.country }
        self.screenData = sortedCountriesList
        self.countriesList = sortedCountriesList
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
        let item = UserDefaultsDomainItem(usecase: selectedCountry, details: [])
        UserDefaultsService.update(item)
    }
}
