
@testable import CoronaVirusApp
import UIKit
import Quick
import Nimble
import Cuckoo
import Combine

class HomeScreenUserInteraction: QuickSpec {
    
    override func spec() {
        
        var sut: HomeScreenViewModel!
        let mock = MockHomeScreenCoordinatorImpl(presenter: UINavigationController())
        
        func initialize() {
            sut = HomeScreenViewModel(repository: MockCovid19RepositoryImpl())
            sut.coordinator = mock
        }
        
        describe("Country selection user interaction calls coordinator delegate.") {
            context("Coordinator delegate called.") {
                beforeEach {
                    initialize()
                    stub(mock) { (stub) in
                        when(stub).openCountrySelection().thenDoNothing()
                    }
                }
                it("Coordinator delegate method called.") {
                    sut.openCountrySelection()
                    verify(mock).openCountrySelection()
                }
            }
        }
    }
}

