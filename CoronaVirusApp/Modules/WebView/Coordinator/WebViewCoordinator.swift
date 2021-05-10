//
//  WebViewCoordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 04.05.2021..
//

import UIKit

class WebViewCoordinator: Coordinator {
    weak var parent: ParentCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var presenter: UINavigationController
    
    private let controller: WebViewViewController
    
    init(presenter: UINavigationController, _ url: URL) {
        self.presenter = presenter
        self.controller = WebViewCoordinator.createController(with: url)
        controller.viewModel.coordinatorDeleagte = self
    }
    
    deinit {
        print("WebView Coordinator deinit")
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    static func createController(with url: URL) -> WebViewViewController {
        let viewModel = WebViewViewModel(screenData: url)
        let controller = WebViewViewController(viewModel: viewModel)
        return controller
    }
}

extension WebViewCoordinator: CoordinatorDelegate {
    func viewControllerDidFinish() {
        parent?.childDidFinish(self)
    }
}
