//
//  PageComingSoonCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 28.04.2021..
//

import UIKit

class PageComingSoonCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var presenter: UINavigationController
    
    let controller: UIViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = PageComingSoonCoordinator.createController()
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

private extension PageComingSoonCoordinator {
    static func createController() -> UIViewController {
        let controller = PageComingSoonViewController()
        return controller
    }
}
