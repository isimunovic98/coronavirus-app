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
    var controller: TabBarViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        super.init()
        self.controller = createController()
    }
    deinit { print("TabCoordinator deinit called.") }
    
    func start() {
        guard let controller = controller else { return }
        presenter.pushViewController(controller, animated: true)
        
    }
    
    func createController() -> TabBarViewController {
        let tabController = TabBarViewController()
        let tabs: [TabBarPage] = [.home, .statistics, .news, .healthTips]
        let viewControllers: [UINavigationController] = tabs.map({ createTabItems(from: $0) })
        tabController.setViewControllers(viewControllers, animated: true)
        return tabController
    }
    
    func createTabItems(from page: TabBarPage) -> UINavigationController {
         switch page {
         case .home:        return createHomeViewController(from: page)
         case .statistics:  return createStatisticsViewController(from: page)
         case .news:        return createLatestNewsViewController(from: page)
         case .healthTips:  return createHealthTipsViewController(from: page)
         }
     }
    
    func createHomeViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        let coordinator = HomeScreenCoordinatorImpl(presenter: presenter)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
        return coordinator.presenter
    }

    func createStatisticsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.presenter
    }

    func createLatestNewsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        let coordinator = DummyCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.presenter
    }

    func createHealthTipsViewController(from page: TabBarPage) -> UINavigationController {
        let presenter = UINavigationController()
        presenter.tabBarItem = UITabBarItem(title: nil, image: page.getIcon(), tag: page.rawValue)
        let coordinator = PageComingSoonCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.presenter
    }
}

extension TabBarCoordinator: ParentCoordinatorDelegate { }

extension TabBarCoordinator: CountrySelectionHandler {
    func openCountrySelection() {
        let child = CountrySelectionCoordinator(presenter: presenter)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
}
