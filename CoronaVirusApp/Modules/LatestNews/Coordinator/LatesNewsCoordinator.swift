//
//  LatesNewsCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 04.05.2021..
//

import UIKit

class LatestNewsCoordinator: Coordinator {
    weak var parent: (ParentCoordinatorDelegate & TabBarCoordinatorDelegate)?
    
    var childCoordinators: [Coordinator] = []
    
    var presenter: UINavigationController
    
    var controller: LatestNewsViewController!
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = LatestNewsCoordinator.createController(coordinatorDelegate: self)
        controller.viewModel.coordinatorDelegate = self
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

private extension LatestNewsCoordinator {
    static func createController(coordinatorDelegate delegate: LatestNewsCoordinatorDelegate) -> LatestNewsViewController {
        let repository = LatestNewsRepositoryImpl()
        let viewModel = LatestNewsViewModel(repository: repository)
        let controller = LatestNewsViewController(viewModel: viewModel)
        controller.viewModel.coordinatorDelegate = delegate
        return controller
    }
}

extension LatestNewsCoordinator: LatestNewsCoordinatorDelegate {
    func openWebView(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        parent?.openWebView(with: url)
    }
}
