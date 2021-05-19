//
//  TabBarViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .systemRed
        self.tabBar.backgroundColor = .backgroundColorSecond
    }
    
    func setNavTitle(_ title: String?) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationItem.backBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
}
