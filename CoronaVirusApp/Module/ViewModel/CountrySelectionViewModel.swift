//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 02.04.2021..
//

import Foundation
import Combine

class CountrySelectionViewModel {
    var coordinatorDelegate: CoordinatorDelegate?
    
    let repository: CountrySelectionRepository
    
    var screenData: [Country] = []
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    let searchPublisher = PassthroughSubject<String, Never>()
    
    init(repository: CountrySelectionRepository) {
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
                let endpoint = RestEndpoints.countriesList
                return self.repository.getCountriesList(using: endpoint)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.screenData = data.sorted { $0.country < $1.country }
                    self.dataReadyPublisher.send()
                    #warning("remove loader screen")
                case .failure(let error):
                    print(error.localizedDescription)
                    #warning("send error and show screen acordingly")
                }
            })
    }
    
    func attachFilterListener(subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        var filter: String = ""
        return subject
            .flatMap{ input -> AnyPublisher<Result<[Country], NetworkError>, Never> in
                #warning("show loader screen")
                filter = input
                let endpoint = RestEndpoints.countriesList
                return self.repository.getCountriesList(using: endpoint)
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    let sortedData = data.sorted { $0.country < $1.country }
                    self.screenData = self.filter(sortedData, with: filter)
                    self.dataReadyPublisher.send()
                    #warning("remove loader screen")
                case .failure(let error):
                    print(error.localizedDescription)
                    #warning("send error and show screen acordingly")
                }
            })
    }
}

extension CountrySelectionViewModel {
    private func filter(_ screenData: [Country], with filter: String) -> [Country] {
        if filter != "" {
            let filteredData = screenData.filter {$0.country.contains(filter)}
            return filteredData
        } else {
            return screenData
        }
    }
    
    func update(_ selectedCountry: String) {
        UserDefaultsService.saveLastSelection(selectedCountry)
    }
}
