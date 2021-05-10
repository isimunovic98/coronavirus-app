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
        label.textAlignment = .center
        label.text = "Page coming soon"
        label.textColor = .systemGray
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
        startAnimation()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}

//MARK: - UI
extension PageComingSoonViewController {
    func setupView() {
            addViews()
            setupAppearance()
            setupLayout()
    }
        
    func addViews() {
        let views = [loadingAnimationView, label]
        view.addSubviews(views)
    }
    
    func setupAppearance() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
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
    
    func stopAnimation() {
        loadingAnimationView.stop()
    }
}
