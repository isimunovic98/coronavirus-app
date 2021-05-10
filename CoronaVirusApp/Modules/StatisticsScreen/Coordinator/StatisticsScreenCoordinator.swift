
import UIKit

class StatisticsScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = .init()
    var presenter: UINavigationController
    var controller: StatistiscScreenViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = StatisticsScreenCoordinator.createController()
        controller.viewModel.coordinator = self
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    static func createController() -> StatistiscScreenViewController {
        let viewModel = StatisticsScreenViewModel(repository: Covid19RepositoryImpl())
        let controller = StatistiscScreenViewController(viewModel: viewModel)
        return controller
    }
    
}
