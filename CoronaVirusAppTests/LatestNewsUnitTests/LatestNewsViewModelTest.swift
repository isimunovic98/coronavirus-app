//
//  LatestNewsViewModelTest.swift
//  CoronaVirusAppTests
//
//  Created by Ivan Simunovic on 07.05.2021..
//

import Cuckoo
import Quick
import Nimble
import Combine
import UIKit

@testable import CoronaVirusApp

class LatestNewsViewModelTest: QuickSpec {

    func getResource<T: Codable>() -> T? {
        let bundle = Bundle.init(for: LatestNewsViewModelTest.self)
        guard let resourcePath = bundle.url(forResource: "LatestNewsList", withExtension: "json"),
        let data = try? Data(contentsOf: resourcePath),
        let parsedData: T = SerializationManager.parseData(jsonData: data) else {
            return nil
        }
        return parsedData
    }
    
    override func spec() {
        describe("Test for view model") {
            let mockRepository = MockLatestNewsRepositoryImpl()
            var viewModel: LatestNewsViewModel!
            var disposeBag = Set<AnyCancellable>()
            
            context("Screen data initialized successfuly") {
                beforeEach {
                    successStub()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(0)
                    expect(viewModel.screenData.count).toEventually(equal(25))
                    expect(viewModel.screenData[0].title).toEventually(equal("Corona Volunteers assisted government in Corona control"))
                    expect(viewModel.screenData[1].source).toEventually(equal("dailymail"))
                    expect(viewModel.screenData[24].publishedAt).toEventually(equal("1 month ago"))
                }
            }
            
            context("Initialization got error") {
                beforeEach {
                    failStub()
                    setupViewModel()
                }
                
                it("Screeen initalized") {
                    //viewModel.loadData.send(0)
                    expect(viewModel.screenData.count).toEventually(equal(0))
                }
            }
            
            func setupViewModel() {
                viewModel = LatestNewsViewModel(repository: mockRepository)
                viewModel.initializeScreenData(with: viewModel.loadData).store(in: &disposeBag)
            }
            
            func successStub() {
                stub(mockRepository) { (mock) in
                    guard let response: LatestNewsResponseItem = getResource() else { return }
                    let publisher = Just<Result<LatestNewsResponseItem, ErrorType>>(.success(response)).eraseToAnyPublisher()
                    when(mock).getLatestNews(withOffset: any()).thenReturn(publisher)
                }
            }
            
            func failStub() {
                stub(mockRepository) { mock in
                    let publisher = Just<Result<LatestNewsResponseItem, ErrorType>>(.failure(.general)).eraseToAnyPublisher()
                    when(mock).getLatestNews(withOffset: any()).thenReturn(publisher)
                }
            }
        }
    }
}

