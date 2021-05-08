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
        for (index, coord) in childCoordinators.enumerated() {
            if coord === coordinator {
                childCoordinators.remove(at: index)
                print("Coordinator \(coordinator) removed.")
            }
        }
    }
}

