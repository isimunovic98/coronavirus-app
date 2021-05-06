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
    var controller: TabBarViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = TabBarCoordinator.createController()
        super.init()
    }
    deinit { print("TabCoordinator deinit called.") }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

private extension TabBarCoordinator {
    static func createController() -> TabBarViewController {
        let tabController = TabBarViewController()
        let tabs: [TabBarPage] = [.home, .statistics, .news, .healthTips]
        let viewControllers: [UINavigationController] = tabs.map({ createTabItems(from: $0) })
        tabController.setViewControllers(viewControllers, animated: true)
        return tabController
    }
    
    static func createTabItems(from page: TabBarPage) -> UINavigationController {
         switch page {
         case .home: return createHomeViewController(from: page)
         case .statistics: return createStatisticsViewController(from: page)
         case .news: return createLatestNewsViewController(from: page)
         case .healthTips: return createHealthTipsViewController(from: page)
         }
     }

}

private extension TabBarCoordinator {
    static func createHomeViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let homeCoordinator = DummyCoordinator(presenter: presenter)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        homeCoordinator.start()
        return homeCoordinator.presenter
    }

    static func createStatisticsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let statisticsCoordinator = DummyCoordinator(presenter: presenter)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        statisticsCoordinator.start()
        return statisticsCoordinator.presenter
    }

    static func createLatestNewsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let latestNewsCoordinator = DummyCoordinator(presenter: presenter)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        latestNewsCoordinator.start()
        return latestNewsCoordinator.presenter
    }

    static func createHealthTipsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        let healthTipsCoordinator = DummyCoordinator(presenter: presenter)
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        healthTipsCoordinator.start()
        return healthTipsCoordinator.presenter
    }
}


