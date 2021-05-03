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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        //coordinator = AppCoordinator(window: window!)
        //coordinator?.start()
        
        let nc = UINavigationController(rootViewController: CountrySelectionViewController(viewModel: CountrySelectionViewModel(repository: Covid19RepositoryImpl())))
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
        
        return true
    }
}

