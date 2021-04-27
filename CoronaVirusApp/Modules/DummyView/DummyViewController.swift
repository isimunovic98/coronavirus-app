//
//  DummyViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 18.04.2021..
//

import UIKit
import SnapKit

class DummyViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Still in development"
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = .black
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}
