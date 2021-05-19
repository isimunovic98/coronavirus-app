//
//  ErrorView.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 27.04.2021..
//

import UIKit

class ErrorView: UIView, RemovableView {
    
    var tryAgainAction: (()->())?
    
    let noInternetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "no-signal")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemRed
        return imageView
    }()
    let virusOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    
    let virusTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    
    let virusThreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "virus")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = label.font.withSize(24)
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textAlignment = .center
        label.textColor = label.textColor.withAlphaComponent(0.4)
        return label
    }()
    let tryAgainButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Please, try again", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func tryAgainTapped() { tryAgainAction?() }
    
    func setViews() {
        backgroundColor = .systemGray6
        tryAgainButtonContainer.addSubview(tryAgainButton)
        addSubviews([virusOneImageView, virusTwoImageView, virusThreeImageView, titleLabel, descriptionLabel, noInternetImageView, tryAgainButtonContainer])
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        setConstraintsVirusOneImageView()
        setConstraintsVirusTwoImageView()
        setConstraintsVirusThreeImageView()
        setConstraintsTitleLabel()
        setConstraintsDescriptionLabel()
        setConstraintsNoInternetImageView()
        setConstraintsTryAgainButtonContainer()
        setConstraintsTryAgainButton()
    }
    
    func configure(with option: ErrorType) {
        noInternetImageView.isHidden = false
        virusOneImageView.isHidden = false
        virusTwoImageView.isHidden = false
        virusThreeImageView.isHidden = false
        switch option {
        case .general:
            titleLabel.text = "Oops!"
            descriptionLabel.text = "Something went wrong."
            tryAgainButton.setTitle("Please, try again", for: .normal)
            noInternetImageView.isHidden = true
        case .noInternet:
            titleLabel.text = "No Internet connection!"
            descriptionLabel.text = "Please check your internet connection."
            tryAgainButton.setTitle("Try again", for: .normal)
            virusOneImageView.isHidden = true
            virusTwoImageView.isHidden = true
            virusThreeImageView.isHidden = true
        default: break
        }
    }
}

extension ErrorView {
    
    func setConstraintsVirusOneImageView() {
        virusOneImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(90)
            make.centerY.equalTo(self.snp.centerY).offset(-100)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func setConstraintsVirusTwoImageView() {
        virusTwoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(70)
            make.centerY.equalTo(self.snp.centerY).offset(-140)
            make.centerX.equalTo(self.snp.centerX).offset(-60)
        }
    }
    
    func setConstraintsVirusThreeImageView() {
        virusThreeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerY.equalTo(self.snp.centerY).offset(-130)
            make.centerX.equalTo(self.snp.centerX).offset(70)
        }
    }
    
    func setConstraintsTitleLabel() {
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(self.snp.centerY).offset(10)
            make.height.equalTo(40)
        }
    }
    
    func setConstraintsDescriptionLabel() {
        descriptionLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
    }
    
    func setConstraintsNoInternetImageView() {
        noInternetImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerY.equalTo(self.snp.centerY).offset(-100)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func setConstraintsTryAgainButtonContainer() {
        tryAgainButtonContainer.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    func setConstraintsTryAgainButton() {
        tryAgainButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
