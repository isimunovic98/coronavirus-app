//
//  EmptyStateView.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 13.05.2021..
//

import UIKit
import Lottie
import SnapKit

class EmptyView: UIView, RemovableView {
    
    var backToSearchAction: (()->())?
    
    let animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        return animationView
    }()    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        #warning("fix color")
        label.textColor = .systemGray
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Sorry, there's no information for your search.\n",
                                       attributes: [.font            : UIFont.boldSystemFont(ofSize: 16),
                                                    .foregroundColor : UIColor.black]))
        text.append(NSAttributedString(string: "We will try to find it.\n",
                                       attributes: [.font : UIFont.boldSystemFont(ofSize: 16)]))

        text.append(NSAttributedString(string: "Please check other countries in the meantime.",
                                       attributes: [.font : UIFont.boldSystemFont(ofSize: 16)]))
        label.attributedText = text
        return label
    }()
    let backToSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back to Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        return button
    }()
    let virus1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    let virus2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    let virus3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    let virus4ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    let virus5ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setAppearance()
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


extension EmptyView {
    
    func setAppearance() {
        #warning("fix background color")
        backgroundColor = .systemGray4
    }
    
    func setViews() {
        addSubviews([animationView, descriptionLabel, backToSearchButton,  virus1ImageView, virus2ImageView, virus3ImageView, virus4ImageView, virus5ImageView])
        backToSearchButton.addTarget(self, action: #selector(backToSearchButtonTapped), for: .touchUpInside)
    }
    
    @objc func backToSearchButtonTapped() { backToSearchAction?() }
    
    func startAnimation() {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            animationView.animation = Animation.named("DarkModeEmptyStateAnimation")
        }
        else {
            animationView.animation = Animation.named("LightModeEmptyStateAnimation")
        }
        animationView.play()
    }
    
    func stopAnimation() { animationView.stop() }
    
    func setConstraints() {
        
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(self.snp.width).dividedBy(1.4)
            make.bottom.equalTo(self.snp.centerY).offset(-50)
            make.centerX.equalTo(self)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).offset(-50)
            make.width.equalToSuperview().dividedBy(1.4)
            make.centerX.equalTo(self)
        }
        
        backToSearchButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.centerX.equalTo(self)
            make.height.equalTo(44)
            make.width.equalTo(self).dividedBy(2)
        }
        
        virus1ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.top.equalToSuperview().offset(30)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        virus2ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(100)
            make.centerX.equalTo(self.snp.leading)
        }
        
        virus3ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.trailing).offset(-10)
        }
        
        virus4ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalTo(backToSearchButton.snp.leading)
            make.top.equalTo(backToSearchButton.snp.bottom).offset(50)
        }
        
        virus5ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalTo(self.snp.trailing).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
