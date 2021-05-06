//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 12.04.2021..
//

import UIKit

class CountrySelectionCoordinator: Coordinator {
    
    weak var parent: ParentCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let controller: CountrySelectionViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = CountrySelectionCoordinator.createController()
    }
    
    func start() {
        controller.viewModel.coordinatorDelegate = self
        presenter.pushViewController(controller, animated: false)
    }
    
    static func createController() -> CountrySelectionViewController {
        let repository = Covid19RepositoryImpl()
        let viewModel = CountrySelectionViewModel(repository: repository)
        let viewController = CountrySelectionViewController(viewModel: viewModel)
        return viewController
    }
}
extension CountrySelectionCoordinator: CoordinatorDelegate {
    func viewControllerDidFinish() {
        parent?.childDidFinish(self)
    }
}
