//
//  PageComingSoonCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 28.04.2021..
//

import UIKit

class PageComingSoonCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let controller: UIViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = PageComingSoonCoordinator.createController()
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: true)
    }
}

private extension PageComingSoonCoordinator {
    static func createController() -> UIViewController {
        let controller = PageComingSoonViewController()
        return controller
    }
}
