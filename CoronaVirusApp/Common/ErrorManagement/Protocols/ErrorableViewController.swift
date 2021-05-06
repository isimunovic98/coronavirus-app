//
//  ErrorableViewController.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 28.04.2021..
//

import UIKit
import Combine

protocol ErrorableViewController {
    var disposeBag: Set<AnyCancellable> { get set }
    func tryAgainAfterError()
}

extension ErrorableViewController where Self: UIViewController {
    
    func initializeErrorSubject(_ subject: AnyPublisher<ErrorType?, Never>) -> AnyCancellable {
        return subject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [unowned self] (error) in
                if let errorExists = error { self.showError(errorExists) } else { self.dismissError() }
            }
    }
    
    private func showError(_ errorType: ErrorType) {
        let errorView = ErrorView()
        errorView.configure(with: errorType)
        errorView.tryAgainAction = tryAgainAfterError
        self.view.addSubview(errorView)
        errorView.snp.makeConstraints { (make) in make.edges.equalToSuperview() }
    }
    
    private func dismissError() {
        for subview in self.view.subviews {
            if let viewToRemove = subview as? ErrorView { viewToRemove.removeFromSuperview() }
        }
    }
}
