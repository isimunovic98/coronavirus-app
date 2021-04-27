//
//  DummyViewControllerCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit

class DummyCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let controller: DummyViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = DummyCoordinator.createController()
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: true)
    }

}

private extension DummyCoordinator {
    static func createController() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
}
