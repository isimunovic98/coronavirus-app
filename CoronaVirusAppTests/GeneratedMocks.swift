// MARK: - Mocks generated from file: CoronaVirusApp/Common/Networking/Repositories/Covid19RepositoryImpl.swift at 2021-05-06 10:39:48 +0000


import Cuckoo
@testable import CoronaVirusApp

import Combine
import Foundation


 class MockCovid19RepositoryImpl: Covid19RepositoryImpl, Cuckoo.ClassMock {
    
     typealias MocksType = Covid19RepositoryImpl
    
     typealias Stubbing = __StubbingProxy_Covid19RepositoryImpl
     typealias Verification = __VerificationProxy_Covid19RepositoryImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Covid19RepositoryImpl?

     func enableDefaultImplementation(_ stub: Covid19RepositoryImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never> {
        
    return cuckoo_manager.call("getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getCountriesList()
                ,
            defaultCall: __defaultImplStub!.getCountriesList())
        
    }
    
    
    
     override func getCountryStatsTotal(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        
    return cuckoo_manager.call("getCountryStatsTotal(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>",
            parameters: (countryName),
            escapingParameters: (countryName),
            superclassCall:
                
                super.getCountryStatsTotal(for: countryName)
                ,
            defaultCall: __defaultImplStub!.getCountryStatsTotal(for: countryName))
        
    }
    
    
    
     override func getCountryStats(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never> {
        
    return cuckoo_manager.call("getCountryStats(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>",
            parameters: (countryName),
            escapingParameters: (countryName),
            superclassCall:
                
                super.getCountryStats(for: countryName)
                ,
            defaultCall: __defaultImplStub!.getCountryStats(for: countryName))
        
    }
    
    
    
     override func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never> {
        
    return cuckoo_manager.call("getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getWorldwideData()
                ,
            defaultCall: __defaultImplStub!.getWorldwideData())
        
    }
    

	 struct __StubbingProxy_Covid19RepositoryImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getCountriesList() -> Cuckoo.ClassStubFunction<(), AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19RepositoryImpl.self, method: "getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>", parameterMatchers: matchers))
	    }
	    
	    func getCountryStatsTotal<M1: Cuckoo.Matchable>(for countryName: M1) -> Cuckoo.ClassStubFunction<(String), AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: countryName) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19RepositoryImpl.self, method: "getCountryStatsTotal(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>", parameterMatchers: matchers))
	    }
	    
	    func getCountryStats<M1: Cuckoo.Matchable>(for countryName: M1) -> Cuckoo.ClassStubFunction<(String), AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: countryName) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19RepositoryImpl.self, method: "getCountryStats(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>", parameterMatchers: matchers))
	    }
	    
	    func getWorldwideData() -> Cuckoo.ClassStubFunction<(), AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19RepositoryImpl.self, method: "getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Covid19RepositoryImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getCountriesList() -> Cuckoo.__DoNotUse<(), AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getCountryStatsTotal<M1: Cuckoo.Matchable>(for countryName: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: countryName) { $0 }]
	        return cuckoo_manager.verify("getCountryStatsTotal(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getCountryStats<M1: Cuckoo.Matchable>(for countryName: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: countryName) { $0 }]
	        return cuckoo_manager.verify("getCountryStats(for: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getWorldwideData() -> Cuckoo.__DoNotUse<(), AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class Covid19RepositoryImplStub: Covid19RepositoryImpl {
    

    

    
     override func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>).self)
    }
    
     override func getCountryStatsTotal(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>).self)
    }
    
     override func getCountryStats(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>).self)
    }
    
     override func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>).self)
    }
    
}

