
import UIKit

class HomeScreenCoordinatorImpl: HomeScreenCoordinator {
    
    var childCoordinators: [Coordinator] = .init()
    var presenter: UINavigationController
    weak var parentCoordinator: (ParentCoordinatorDelegate & CountrySelectionHandler)?
    var controller: HomeScreenViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = HomeScreenCoordinatorImpl.createController()
    }
    deinit { print("HomeScreenCoordinatorImpl deinit called.") }
    
    func start() {
        controller.viewModel.coordinator = self
        presenter.pushViewController(controller, animated: true) }
    
    static func createController() -> HomeScreenViewController {
        let vm = HomeScreenViewModel(repository: Covid19RepositoryImpl())
        let vc = HomeScreenViewController(viewModel: vm)
        return vc
    }
    
    func openCountrySelection() {
        parentCoordinator?.openCountrySelection()
    }
    
    func viewControllerDidFinish() { 
        parentCoordinator?.childDidFinish(self)
    }
}

