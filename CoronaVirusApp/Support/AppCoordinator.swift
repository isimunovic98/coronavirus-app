//
//  AppCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let window: UIWindow
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.presenter = UINavigationController()
    }
}

extension AppCoordinator {
    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        presentTabBar()
    }
    
    func presentTabBar() {
        let child = TabBarCoordinator(presenter: presenter)
        childCoordinators.append(child)
        child.start()
    }
}
