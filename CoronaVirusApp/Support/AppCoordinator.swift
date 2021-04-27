//
//  AppCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
}

extension AppCoordinator {
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        presentTabBar()
    }
    
    func presentTabBar() {
        let child = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
