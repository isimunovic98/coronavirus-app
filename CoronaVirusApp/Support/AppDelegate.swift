//
//  AppDelegate.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 16.03.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        
        return true
    }
}

