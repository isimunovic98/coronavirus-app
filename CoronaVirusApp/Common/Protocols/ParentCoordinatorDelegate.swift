//
//  ParentCoordinatorDelegate.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

protocol ParentCoordinatorDelegate: Coordinator { }

extension ParentCoordinatorDelegate where Self: Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({$0 !== coordinator})
    }
}

