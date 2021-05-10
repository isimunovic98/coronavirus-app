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
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }    
    func start() {
        presenter.pushViewController(PageComingSoonCoordinator.createController(), animated: true)
    }
    static func createController() -> UIViewController {
        return PageComingSoonViewController()
    }
}
