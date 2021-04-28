//
//  PageComingSoonViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 28.04.2021..
//

import UIKit
import SnapKit
import Lottie

class PageComingSoonViewController: UIViewController {
    //MARK: Properties
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView(name: "loadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Montserrat", size: 24)
        label.text = "Page coming son"
        return label
    }()
}

//MARK: - Lifecycle
extension PageComingSoonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - UI
extension PageComingSoonViewController {
    func setupView() {
            addViews()
            setupAppearance()
            setupLayout()
            startAnimation()
    }
        
    func addViews() {
        let views = [loadingAnimationView, label]
        view.addSubviews(views)
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemGray6
    }
    
    func setupLayout() {
        loadingAnimationView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(loadingAnimationView)
            make.top.equalTo(loadingAnimationView.snp.bottom)
        }
    }
    
    func startAnimation() {
        loadingAnimationView.loopMode = .loop
        loadingAnimationView.play()
    }
}
