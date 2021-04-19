//
//  CountrySelectionViewModelTest.swift
//  CoronaVirusAppTests
//
//  Created by Ivan Simunovic on 20.04.2021..
//

import Cuckoo
import Quick
import Nimble
import Combine
import UIKit

@testable import CoronaVirusApp

class CountrySelectionViewModelTest: QuickSpec {

    func getResource<T: Codable>() -> T? {
        let bundle = Bundle.init(for: CoronaVirusAppTests.self)
        
        guard let resourcePath = bundle.url(forResource: "CountriesResponse", withExtension: "json"),
        let data = try? Data(contentsOf: resourcePath),
        let parsedData: T = SerializationManager.parseData(jsonData: data) else {
            return nil
        }
        return parsedData
    }
    
    override func spec() {
        describe("Test for view model") {
            let mockRepository = MockCovid19Repository()
            var viewModel: CountrySelectionViewModel!
            var disposeBag = Set<AnyCancellable>()
            
            context("Screen data initialized successfuly") {
                beforeEach {
                    successStub()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(false)
                    expect(viewModel.screenData.count).toEventually(equal(248))
                    expect(viewModel.screenData[0].country).toEventually(equal("Suriname"))
                    expect(viewModel.screenData[1].iso).toEventually(equal("AM"))
                    expect(viewModel.screenData[2].slug).toEventually(equal("dominican-republic"))
                }
            }
            
            context("Initialization got error") {
                beforeEach {
                    failStub()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(true)
                    expect(viewModel.screenData.count).toEventually(equal(0))
                }
            }
            
            func setupViewModel() {
                viewModel = CountrySelectionViewModel(repository: mockRepository)
                viewModel.initializeScreenData(with: viewModel.loadData).store(in: &disposeBag)
            }
            
            func successStub() {
                stub(mockRepository) { (mock) in
                    guard let response: [Country] = getResource() else {
                        return
                    }
                    let endpoint = RestEndpoints.countriesList
                    let publisher = CurrentValueSubject<Result<[Country], NetworkError>, Never>(.success(response)).eraseToAnyPublisher()
                    when(mock.getCountriesList(using: endpoint).thenReturn(publisher))

                }
            }
            
            func failStub() {
                stub(mockRepository) { mock in
                    let error = NetworkError.connectionTimedOut
                    let endpoint = RestEndpoints.countriesList
                    let publisher =  CurrentValueSubject<Result<[Country], NetworkError>, Never>(.failure(error)).eraseToAnyPublisher()
                    when(mock.getCountriesList(using: endpoint).thenReturn(publisher))
                   
                }
            }
        }
    }
}

