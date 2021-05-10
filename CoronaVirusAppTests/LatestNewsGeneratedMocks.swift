// MARK: - Mocks generated from file: CoronaVirusApp/Modules/LatestNews/Repository/LatestNewsRepository.swift at 2021-05-07 10:59:40 +0000

//
//  LatestNewsRepository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 30.04.2021..
//

import Cuckoo
@testable import CoronaVirusApp

import Combine
import Foundation


 class MockLatestNewsRepository: LatestNewsRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = LatestNewsRepository
    
     typealias Stubbing = __StubbingProxy_LatestNewsRepository
     typealias Verification = __VerificationProxy_LatestNewsRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LatestNewsRepository?

     func enableDefaultImplementation(_ stub: LatestNewsRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never> {
        
    return cuckoo_manager.call("getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>",
            parameters: (offset),
            escapingParameters: (offset),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getLatestNews(withOffset: offset))
        
    }
    

	 struct __StubbingProxy_LatestNewsRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getLatestNews<M1: Cuckoo.Matchable>(withOffset offset: M1) -> Cuckoo.ProtocolStubFunction<(Int), AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: offset) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLatestNewsRepository.self, method: "getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LatestNewsRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getLatestNews<M1: Cuckoo.Matchable>(withOffset offset: M1) -> Cuckoo.__DoNotUse<(Int), AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: offset) { $0 }]
	        return cuckoo_manager.verify("getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LatestNewsRepositoryStub: LatestNewsRepository {
    

    

    
     func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>).self)
    }
    
}



 class MockLatestNewsRepositoryImpl: LatestNewsRepositoryImpl, Cuckoo.ClassMock {
    
     typealias MocksType = LatestNewsRepositoryImpl
    
     typealias Stubbing = __StubbingProxy_LatestNewsRepositoryImpl
     typealias Verification = __VerificationProxy_LatestNewsRepositoryImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LatestNewsRepositoryImpl?

     func enableDefaultImplementation(_ stub: LatestNewsRepositoryImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never> {
        
    return cuckoo_manager.call("getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>",
            parameters: (offset),
            escapingParameters: (offset),
            superclassCall:
                
                super.getLatestNews(withOffset: offset)
                ,
            defaultCall: __defaultImplStub!.getLatestNews(withOffset: offset))
        
    }
    

	 struct __StubbingProxy_LatestNewsRepositoryImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getLatestNews<M1: Cuckoo.Matchable>(withOffset offset: M1) -> Cuckoo.ClassStubFunction<(Int), AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: offset) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLatestNewsRepositoryImpl.self, method: "getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LatestNewsRepositoryImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getLatestNews<M1: Cuckoo.Matchable>(withOffset offset: M1) -> Cuckoo.__DoNotUse<(Int), AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: offset) { $0 }]
	        return cuckoo_manager.verify("getLatestNews(withOffset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LatestNewsRepositoryImplStub: LatestNewsRepositoryImpl {
    

    

    
     override func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>).self)
    }
    
}

