//
//  ErrorableViewModel.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 28.04.2021..
//

import Foundation
import Combine

protocol ErrorableViewModel {
    var errorSubject: PassthroughSubject<ErrorType?, Never> { get set }
}

extension ErrorableViewModel {

    func handleError(_ errorType: ErrorType?) {
        errorSubject.send(errorType)
    }
}
