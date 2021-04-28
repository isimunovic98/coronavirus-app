//
//  TabCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 11.04.2021..
//

import UIKit

class TabBarCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let tabController: TabBarViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabController = TabBarCoordinator.createController()
        super.init()
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
}

extension TabBarCoordinator {
    func start() {
        navigationController.pushViewController(tabController, animated: true)
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
         case .home:
            return createHomeViewController(from: page)

         case .statistics:
            return createStatisticsViewController(from: page)

         case .news:
            return createLatestNewsViewController(from: page)

         case .healthTips:
            return createHealthTipsViewController(from: page)
         }
     }

}

private extension TabBarCoordinator {
    static func createHomeViewController(from page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let homeCoordinator = DummyCoordinator(navigationController: navigationController)
        
        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        
        homeCoordinator.start()
        
        return homeCoordinator.navigationController
    }

    static func createStatisticsViewController(from page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let statisticsCoordinator = DummyCoordinator(navigationController: navigationController)

        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        
        statisticsCoordinator.start()
        
        return statisticsCoordinator.navigationController
    }

    static func createLatestNewsViewController(from page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let latestNewsCoordinator = DummyCoordinator(navigationController: navigationController)

        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        
        latestNewsCoordinator.start()
        
        return latestNewsCoordinator.navigationController
    }

    static func createHealthTipsViewController(from page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let healthTipsCoordinator = DummyCoordinator(navigationController: navigationController)

        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)

        healthTipsCoordinator.start()
        
        return healthTipsCoordinator.navigationController
    }
}


