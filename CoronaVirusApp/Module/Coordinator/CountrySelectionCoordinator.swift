//
//  CountrySelectionViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 12.04.2021..
//

import UIKit

class CountrySelectionCoordinator: Coordinator {
    var parent: ParentCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CountrySelectionCoordinator {
    
    func start() {
        let repository = CountrySelectionRepositoryImpl()
        let viewModel = CountrySelectionViewModel(repository: repository)
        viewModel.coordinatorDelegate = self
        let viewController = CountrySelectionViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension CountrySelectionCoordinator: CoordinatorDelegate {
    func viewControllerDidFinish() {
        if let parent = parent {
            parent.childDidFinish(self)
        }
    }
    
}
