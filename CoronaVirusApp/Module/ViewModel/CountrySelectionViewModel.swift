//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 02.04.2021..
//

import Foundation
import Combine

class CountrySelectionViewModel {
    weak var coordinatorDelegate: CoordinatorDelegate?
    
    let repository: CountrySelectionRepository
    
    var screenData: [Country] = []
    
    var disposeBag: Set<AnyCancellable> = []
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    
    init(repository: CountrySelectionRepository) {
        self.repository = repository
        initializeScreenData(with: loadData)
    }
    
    deinit {
        print("CountrySelection VM deinit")
    }
}

extension CountrySelectionViewModel {
    func initializeScreenData(with subject: CurrentValueSubject<Bool, Never>) {
        subject
            .flatMap({ [unowned self] shouldShowLoader -> AnyPublisher<Result<[Country], NetworkError>, Never> in
                let endpoint = RestEndpoints.countriesList
                return self.repository.getCountriesList(using: endpoint)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.screenData = data
                    print(data)
                    self.dataReadyPublisher.send()
//                    self.shouldShowBlurView.send(false)
                case .failure(let error):
                    print(error.localizedDescription)
//                    self.errorPublisher.send(error.localizedDescription)
                }
            })
            .store(in: &disposeBag)
    }
}
