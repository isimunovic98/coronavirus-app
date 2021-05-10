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
    var controller: UIViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = DummyCoordinator.createController()
    }
    deinit { print("DummyCoordinator deinit called.") }
    
    func start() { presenter.pushViewController(controller, animated: true) }
    static func createController() -> UIViewController { return DummyViewController() }
}
