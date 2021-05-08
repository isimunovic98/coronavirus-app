//
//  TabCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 11.04.2021..
//

import UIKit

class TabBarCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    var controller: TabBarViewController = .init()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        super.init()
        self.controller = createController()
    }
    deinit { print("TabCoordinator deinit called.") }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

private extension TabBarCoordinator {
    func createController() -> TabBarViewController {
        let tabController = TabBarViewController()
        let tabs: [TabBarPage] = [.home, .statistics, .news, .healthTips]
        let viewControllers: [UINavigationController] = tabs.map({ createTabItems(from: $0) })
        tabController.setViewControllers(viewControllers, animated: true)
        return tabController
    }
    
    func createTabItems(from page: TabBarPage) -> UINavigationController {
         switch page {
         case .home: return createHomeViewController(from: page)
         case .statistics: return createStatisticsViewController(from: page)
         case .news: return createLatestNewsViewController(from: page)
         case .healthTips: return createHealthTipsViewController(from: page)
         }
     }

}

private extension TabBarCoordinator {
    func createHomeViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        coordinator.start()
        return coordinator.presenter
    }

    func createStatisticsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        coordinator.start()
        return coordinator.presenter
    }

    func createLatestNewsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        coordinator.start()
        return coordinator.presenter
    }

    func createHealthTipsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        coordinator.start()
        return coordinator.presenter
    }
}


