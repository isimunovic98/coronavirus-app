//
//  StatsScreenInitialization.swift
//  CoronaVirusAppTests
//
//  Created by Tomislav Gelesic on 20.05.2021..
//

@testable import CoronaVirusApp
import Cuckoo
import Quick
import Nimble
import Combine

class StatisticsScreenInitialization: QuickSpec {
    
    func getLocalResource<T: Codable>(_ fileName: String) -> T? {
        let bundle = Bundle.init(for: StatisticsScreenInitialization.self)
        guard let resourcePath = bundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: resourcePath),
              let parsedData: T = SerializationManager.parseData(jsonData: data)
        else { return nil }
        return parsedData
    }
    
    override func spec() {
        describe("Test for view model") {
            let mockRepository = MockCovid19RepositoryImpl()
            var viewModel: StatisticsScreenViewModel!
            var disposeBag = Set<AnyCancellable>()
            
            context("Screen data for country initialized successfuly") {
                beforeEach {
                    successStubCountrySelected()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    viewModel.fetchScreenDataSubject.send((.country("croatia"), false))
                    expect(viewModel.screenData.cardTitle).toEventually(equal("Croatia"))
                    expect(viewModel.screenData.active).toEventually(equal(11265))
                    expect(viewModel.screenData.centerLongitude).toEventually(equal(15.2))
                }
            }
            
            context("Screen data for worldwide initialized successfuly") {
                beforeEach {
                    successStubWorldwideSelected()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    viewModel.fetchScreenDataSubject.send((.worldwide, false))
                    expect(viewModel.screenData.screenTitle).toEventually(equal("Statistics Worldwide"))
                    expect(viewModel.screenData.cardTitle).toEventually(equal("Worldwide"))
                    expect(viewModel.screenData.confirmed).toEventually(equal(131539636))
                    expect(viewModel.screenData.annotations.count).toEventually(equal(3))
                }
            }
            
            
            
                context("Initialization got error") {
                    beforeEach {
                        failStub()
                        setupViewModel()
                    }

                    it("Screeen initalized") {
                        viewModel.fetchScreenDataSubject.send((.worldwide, false))
                        expect(viewModel.screenData.screenTitle).toEventually(equal("Statistics"))
                        expect(viewModel.screenData.cardTitle).toEventually(equal("Unknown"))
                        expect(viewModel.screenData.annotations.count).toEventually(equal(0))
                    }
                }
            
            func setupViewModel() {
                viewModel = StatisticsScreenViewModel(repository: mockRepository)
                viewModel.initializeFetchScreenDataSubject(viewModel.fetchScreenDataSubject).store(in: &disposeBag)
            }
            
            func successStubCountrySelected() {
                stub(mockRepository) { (mock) in
                    guard let response: [CountryResponseItem] = self.getLocalResource("Covid19CountryStats") else { return }
                    let publisher = Just<Result<[CountryResponseItem], ErrorType>>(.success(response)).eraseToAnyPublisher()
                    when(mock).getCountryStats(for: any()).thenReturn(publisher)
                }
            }
            
            func successStubWorldwideSelected() {
                stub(mockRepository) { (mock) in
                    guard let response: WorldwideResponseItem = self.getLocalResource("Covid19WorldwideStats") else { return }
                    let publisher = Just<Result<WorldwideResponseItem, ErrorType>>(.success(response)).eraseToAnyPublisher()
                    when(mock).getWorldwideData().thenReturn(publisher)
                }
            }
            
            func failStub() {
                stub(mockRepository) { mock in
                    let publisher = Just<Result<WorldwideResponseItem, ErrorType>>(.failure(.general)).eraseToAnyPublisher()
                    when(mock).getWorldwideData().thenReturn(publisher)
                }
            }
        }
    }
}
