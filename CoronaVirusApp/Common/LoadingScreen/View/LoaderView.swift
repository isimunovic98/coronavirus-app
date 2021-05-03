//
//  LoadingScreenViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 14.04.2021..
//

import UIKit
import SnapKit
import Lottie

class LoaderView: UIView {
    //MARK: Properties
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView(name: "loadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 16)
        label.text = "Loading..."
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
extension LoaderView {
    func setupView() {
        addViews()
        setupAppearance()
        setupLayout()
    }
    
    func addViews() {
        let views = [loadingAnimationView, loadingLabel]
        addSubviews(views)
    }
    
    func setupAppearance() {
        backgroundColor = .systemGray6
    }
    
    func setupLayout() {
        loadingAnimationView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        loadingLabel.snp.makeConstraints { (make) in
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
