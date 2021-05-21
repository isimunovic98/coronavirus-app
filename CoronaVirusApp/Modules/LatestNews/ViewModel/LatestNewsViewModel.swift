//
//  LatestNewsViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 30.04.2021..
//

import Foundation
import Combine

class LatestNewsViewModel: LoaderViewModel, ErrorableViewModel {
    var loadingInProgress = false
    var pagesAvailable = true
    var screenData: [LatestNewsDomainItem] = []
    private var paginationInformation: PaginationInformation?
    var coordinatorDelegate: LatestNewsCoordinatorDelegate?
    
    let loadData = CurrentValueSubject<Int, Never>(0)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    var loaderPublisher = CurrentValueSubject<Bool, Never>(true)
    var errorSubject = PassthroughSubject<ErrorType?, Never>()
    
    
    private let repository: LatestNewsRepository
    
    init(repository: LatestNewsRepository) {
        self.repository = repository
    }
    
    deinit {
        print("LatestNewsViewModel deinit")
    }
}

extension LatestNewsViewModel {
    func initializeScreenData(with subject: CurrentValueSubject<Int, Never>) -> AnyCancellable {
        return subject
            .flatMap({ [unowned self] offset -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never> in
                ///if paginationInformation doesn't exist send request with offset = 0, in contrary send request for new data
                guard let currentOffset = paginationInformation?.offset else {
                    self.loaderPublisher.send(true)
                    return self.repository.getLatestNews(withOffset: offset)
                }
                self.checkPagesAvailability()
                self.loadingInProgress = true
                return self.repository.getLatestNews(withOffset: currentOffset + offset)
            })
            .map({ [unowned self] responseData -> Result<[LatestNewsDomainItem], ErrorType> in
                switch responseData {
                case .success(let responseData):
                    self.paginationInformation = responseData.paginationInformation
                    let domainItems = responseData.articles.map({return LatestNewsDomainItem(with: $0)})
                    return .success(domainItems)
                case .failure(let error):
                    return .failure(error)
                }
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    loadingInProgress ? self.addScreenData(data) : self.setScreenData(data)
                    self.loadingInProgress = false
                    self.dataReadyPublisher.send()
                    self.loaderPublisher.send(false)
                    self.handleError(nil)
                case .failure(let error):
                    self.loaderPublisher.send(false)
                    print(error.localizedDescription)
                    self.handleError(error)
                }
            })
    }
}
//MARK: - Private Methods
private extension LatestNewsViewModel {
    func setScreenData(_ data: [LatestNewsDomainItem]) {
        screenData = data
    }
    
    func addScreenData(_ data: [LatestNewsDomainItem]) {
        screenData.append(contentsOf: data)
    }
    
    func checkPagesAvailability() {
        let totalResults = paginationInformation?.total ?? 0
        let resultsPerPage = paginationInformation?.limit ?? 25
        let fetchedResults = paginationInformation?.offset ?? 25
        pagesAvailable = fetchedResults + resultsPerPage < totalResults
    }
}

//MARK: - Navigation Methods
extension LatestNewsViewModel {
    func openWebView(of index: Int) {
        let urlString = screenData[index].url
        coordinatorDelegate?.openWebView(with: urlString)
    }
}
