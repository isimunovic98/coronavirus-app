//
//  DummyViewControllerCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit

class DummyCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var presenter: UINavigationController
    
    let controller: DummyViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = DummyCoordinator.createController()
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    static func createController() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
}
