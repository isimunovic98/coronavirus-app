//
//  HomeScreenInitTests.swift
//  CoronaVirusAppTests
//
//  Created by Tomislav Gelesic on 03.05.2021..
//

@testable import CoronaVirusApp
import Cuckoo
import Quick
import Nimble
import Combine

class HomeScreenInitialization: QuickSpec {
    
    func getLocalResource<T: Codable>(_ fileName: String) -> T? {
        let bundle = Bundle.init(for: HomeScreenInitialization.self)
        guard let resourcePath = bundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: resourcePath),
              let parsedData: T = SerializationManager.parseData(jsonData: data)
        else { return nil }
        return parsedData
    }
    
    override func spec() {
        
        var disposeBag = Set<AnyCancellable>()
        let mock = MockCovid19RepositoryImpl()
        var sut: HomeScreenViewModel!
        var alertCalled: Bool = false
        
        describe("Request") {
            context("country stats initialize success screen.") {
                beforeEach {
                    initialize()
                    stubCountryStats(withError: nil)
                    stubCountryStatsTotal(withError: nil)
                    subscribeSUTSubjects()
                }
                it("Success screen initialized.") {
                    let expected = 19
                    sut.usecase = .country("croatia")
                    sut.fetchScreenDataSubject.send()
                    expect(sut.screenData.details.count).toEventually(equal(expected))
                }
            }
            
            context("country stats initialize fail screen.") {
                beforeEach {
                    initialize()
                    stubCountryStats(withError: .general)
                    stubCountryStatsTotal(withError: .noInternet)
                    subscribeSUTSubjects()
                }
                it("Fail screen initialized.") {
                    let expected = true
                    sut.fetchScreenDataSubject.send()
                    expect(alertCalled).toEventually(equal(expected))
                }
            }
            
            context("worldwide stats initialize success screen.") {
                beforeEach {
                    initialize()
                    stubWorldwideStats(withError: nil)
                    subscribeSUTSubjects()
                }
                it("Success screen initialized.") {
                    let expected = 3
                    sut.usecase = .worldwide
                    sut.fetchScreenDataSubject.send()
                    expect(sut.screenData.details.count).toEventually(equal(expected))
                }
            }
            
            context("worldwide stats initialize fail screen.") {
                beforeEach {
                    initialize()
                    stubWorldwideStats(withError: .general)
                    subscribeSUTSubjects()
                }
                it("Fail screen initialized.") {
                    let expected = true
                    sut.fetchScreenDataSubject.send()
                    expect(alertCalled).toEventually(equal(expected))
                }
            }
        }
        
        
        func initialize() {
            sut = HomeScreenViewModel(repository: mock)
        }
        
        func subscribeSUTSubjects() {
            sut.initializeFetchScreenDataSubject(sut.fetchScreenDataSubject.eraseToAnyPublisher())
                .store(in: &disposeBag)
            sut.errorSubject
                .sink { (_) in alertCalled = true }
                .store(in: &disposeBag)
        }
        
        func stubCountryStats(withError error: ErrorType?) {
            if let error = error {
                stub(mock) { stub in
                    let publisher = Just(Result<[CountryResponseItem], ErrorType>.failure(error)).eraseToAnyPublisher()
                    when(stub).getCountryStats(for: any()).thenReturn(publisher)
                }
            } else {
                stub(mock) { [unowned self] stub in
                    if let countryStatsResponse: [CountryResponseItem] = self.getLocalResource("Covid19CountryStats") {
                        let publisher = Just(Result<[CountryResponseItem], ErrorType>.success(countryStatsResponse)).eraseToAnyPublisher()
                        when(stub).getCountryStats(for: any()).thenReturn(publisher)
                    }
                }
            }
        }
        
        func stubCountryStatsTotal(withError error: ErrorType?) {
            if let error = error {
                stub(mock) { stub in
                    let publisher = Just(Result<[CountryResponseItem], ErrorType>.failure(error)).eraseToAnyPublisher()
                    when(stub).getCountryStatsTotal(for: any()).thenReturn(publisher)
                }
            } else {
                stub(mock) { [unowned self] stub in
                    if let countryStatsResponse: [CountryResponseItem] = self.getLocalResource("Covid19CountryTotalStats") {
                        let publisher = Just(Result<[CountryResponseItem], ErrorType>.success(countryStatsResponse)).eraseToAnyPublisher()
                        when(stub).getCountryStatsTotal(for: any()).thenReturn(publisher)
                    }
                }
            }
        }
        func stubWorldwideStats(withError error: ErrorType?) {
            if let error = error {
                stub(mock) { stub in
                    let publisher = Just(Result<WorldwideResponseItem, ErrorType>.failure(error)).eraseToAnyPublisher()
                    when(stub).getWorldwideData().thenReturn(publisher)
                }
            }
            else {
                stub(mock) { [unowned self] stub in
                    if let worldwideStatsResponse: WorldwideResponseItem = self.getLocalResource("Covid19WorldwideStats") {
                        let publisher = Just(Result<WorldwideResponseItem, ErrorType>.success(worldwideStatsResponse)).eraseToAnyPublisher()
                        when(stub).getWorldwideData().thenReturn(publisher)
                    }
                }
            }
        }
    }
}
