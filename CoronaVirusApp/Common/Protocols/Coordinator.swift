//
//  Coordinator.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
