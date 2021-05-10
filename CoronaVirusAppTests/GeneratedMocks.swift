// MARK: - Mocks generated from file: CoronaVirusApp/Common/Networking/Repositories/Covid19RepositoryImpl.swift at 2021-05-09 13:07:46 +0000


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


// MARK: - Mocks generated from file: CoronaVirusApp/Modules/HomeScreen/Coordinators/HomeScreenCoordinatorImpl.swift at 2021-05-09 13:07:46 +0000


import Cuckoo
@testable import CoronaVirusApp

import UIKit


 class MockHomeScreenCoordinatorImpl: HomeScreenCoordinatorImpl, Cuckoo.ClassMock {
    
     typealias MocksType = HomeScreenCoordinatorImpl
    
     typealias Stubbing = __StubbingProxy_HomeScreenCoordinatorImpl
     typealias Verification = __VerificationProxy_HomeScreenCoordinatorImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: HomeScreenCoordinatorImpl?

     func enableDefaultImplementation(_ stub: HomeScreenCoordinatorImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var childCoordinators: [Coordinator] {
        get {
            return cuckoo_manager.getter("childCoordinators",
                superclassCall:
                    
                    super.childCoordinators
                    ,
                defaultCall: __defaultImplStub!.childCoordinators)
        }
        
        set {
            cuckoo_manager.setter("childCoordinators",
                value: newValue,
                superclassCall:
                    
                    super.childCoordinators = newValue
                    ,
                defaultCall: __defaultImplStub!.childCoordinators = newValue)
        }
        
    }
    
    
    
     override var presenter: UINavigationController {
        get {
            return cuckoo_manager.getter("presenter",
                superclassCall:
                    
                    super.presenter
                    ,
                defaultCall: __defaultImplStub!.presenter)
        }
        
        set {
            cuckoo_manager.setter("presenter",
                value: newValue,
                superclassCall:
                    
                    super.presenter = newValue
                    ,
                defaultCall: __defaultImplStub!.presenter = newValue)
        }
        
    }
    
    
    
     override var parentCoordinator: (ParentCoordinatorDelegate & CountrySelectionHandler)? {
        get {
            return cuckoo_manager.getter("parentCoordinator",
                superclassCall:
                    
                    super.parentCoordinator
                    ,
                defaultCall: __defaultImplStub!.parentCoordinator)
        }
        
        set {
            cuckoo_manager.setter("parentCoordinator",
                value: newValue,
                superclassCall:
                    
                    super.parentCoordinator = newValue
                    ,
                defaultCall: __defaultImplStub!.parentCoordinator = newValue)
        }
        
    }
    
    
    
     override var controller: HomeScreenViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    super.controller
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
        set {
            cuckoo_manager.setter("controller",
                value: newValue,
                superclassCall:
                    
                    super.controller = newValue
                    ,
                defaultCall: __defaultImplStub!.controller = newValue)
        }
        
    }
    

    

    
    
    
     override func start()  {
        
    return cuckoo_manager.call("start()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.start()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
     override func openCountrySelection()  {
        
    return cuckoo_manager.call("openCountrySelection()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.openCountrySelection()
                ,
            defaultCall: __defaultImplStub!.openCountrySelection())
        
    }
    
    
    
     override func viewControllerDidFinish()  {
        
    return cuckoo_manager.call("viewControllerDidFinish()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.viewControllerDidFinish()
                ,
            defaultCall: __defaultImplStub!.viewControllerDidFinish())
        
    }
    

	 struct __StubbingProxy_HomeScreenCoordinatorImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var childCoordinators: Cuckoo.ClassToBeStubbedProperty<MockHomeScreenCoordinatorImpl, [Coordinator]> {
	        return .init(manager: cuckoo_manager, name: "childCoordinators")
	    }
	    
	    
	    var presenter: Cuckoo.ClassToBeStubbedProperty<MockHomeScreenCoordinatorImpl, UINavigationController> {
	        return .init(manager: cuckoo_manager, name: "presenter")
	    }
	    
	    
	    var parentCoordinator: Cuckoo.ClassToBeStubbedOptionalProperty<MockHomeScreenCoordinatorImpl, (ParentCoordinatorDelegate & CountrySelectionHandler)> {
	        return .init(manager: cuckoo_manager, name: "parentCoordinator")
	    }
	    
	    
	    var controller: Cuckoo.ClassToBeStubbedProperty<MockHomeScreenCoordinatorImpl, HomeScreenViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    func start() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeScreenCoordinatorImpl.self, method: "start()", parameterMatchers: matchers))
	    }
	    
	    func openCountrySelection() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeScreenCoordinatorImpl.self, method: "openCountrySelection()", parameterMatchers: matchers))
	    }
	    
	    func viewControllerDidFinish() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeScreenCoordinatorImpl.self, method: "viewControllerDidFinish()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HomeScreenCoordinatorImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var childCoordinators: Cuckoo.VerifyProperty<[Coordinator]> {
	        return .init(manager: cuckoo_manager, name: "childCoordinators", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var presenter: Cuckoo.VerifyProperty<UINavigationController> {
	        return .init(manager: cuckoo_manager, name: "presenter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var parentCoordinator: Cuckoo.VerifyOptionalProperty<(ParentCoordinatorDelegate & CountrySelectionHandler)> {
	        return .init(manager: cuckoo_manager, name: "parentCoordinator", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyProperty<HomeScreenViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func start() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("start()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func openCountrySelection() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("openCountrySelection()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func viewControllerDidFinish() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("viewControllerDidFinish()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HomeScreenCoordinatorImplStub: HomeScreenCoordinatorImpl {
    
    
     override var childCoordinators: [Coordinator] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([Coordinator]).self)
        }
        
        set { }
        
    }
    
    
     override var presenter: UINavigationController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UINavigationController).self)
        }
        
        set { }
        
    }
    
    
     override var parentCoordinator: (ParentCoordinatorDelegate & CountrySelectionHandler)? {
        get {
            return DefaultValueRegistry.defaultValue(for: ((ParentCoordinatorDelegate & CountrySelectionHandler)?).self)
        }
        
        set { }
        
    }
    
    
     override var controller: HomeScreenViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (HomeScreenViewController).self)
        }
        
        set { }
        
    }
    

    

    
     override func start()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func openCountrySelection()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func viewControllerDidFinish()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

