// MARK: - Mocks generated from file: CoronaVirusApp/Common/Networking/Repositories/Covid19Repository.swift at 2021-04-28 16:40:15 +0000

//
//  Covid19Repository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 20.04.2021..
//

import Cuckoo
@testable import CoronaVirusApp

import Combine
import Foundation


 class MockCovid19Repository: Covid19Repository, Cuckoo.ProtocolMock {
    
     typealias MocksType = Covid19Repository
    
     typealias Stubbing = __StubbingProxy_Covid19Repository
     typealias Verification = __VerificationProxy_Covid19Repository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Covid19Repository?

     func enableDefaultImplementation(_ stub: Covid19Repository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never> {
        
    return cuckoo_manager.call("getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getCountriesList())
        
    }
    

	 struct __StubbingProxy_Covid19Repository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getCountriesList() -> Cuckoo.ProtocolStubFunction<(), AnyPublisher<Result<[Country], NetworkError>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19Repository.self, method: "getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Covid19Repository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getCountriesList() -> Cuckoo.__DoNotUse<(), AnyPublisher<Result<[Country], NetworkError>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class Covid19RepositoryStub: Covid19Repository {
    

    

    
     func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[Country], NetworkError>, Never>).self)
    }
    
}



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
    

    

    

    
    
    
     override func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never> {
        
    return cuckoo_manager.call("getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getCountriesList()
                ,
            defaultCall: __defaultImplStub!.getCountriesList())
        
    }
    

	 struct __StubbingProxy_Covid19RepositoryImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getCountriesList() -> Cuckoo.ClassStubFunction<(), AnyPublisher<Result<[Country], NetworkError>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCovid19RepositoryImpl.self, method: "getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>", parameterMatchers: matchers))
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
	    func getCountriesList() -> Cuckoo.__DoNotUse<(), AnyPublisher<Result<[Country], NetworkError>, Never>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class Covid19RepositoryImplStub: Covid19RepositoryImpl {
    

    

    
     override func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[Country], NetworkError>, Never>).self)
    }
    
}

