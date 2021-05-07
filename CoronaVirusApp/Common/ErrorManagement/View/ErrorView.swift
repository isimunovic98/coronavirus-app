//
//  ErrorView.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 27.04.2021..
//

import UIKit

class ErrorView: UIView {
    
    var tryAgainAction: (()->())?
    
    let noInternetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "no-signal")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
    
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("Try again!", for: .normal)
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
        addSubviews([virusOneImageView, virusTwoImageView, virusThreeImageView, titleLabel, descriptionLabel, noInternetImageView, tryAgainButton])
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        setConstraintsVirusOneImageView()
        setConstraintsVirusTwoImageView()
        setConstraintsVirusThreeImageView()
        setConstraintsTitleLabel()
        setConstraintsDescriptionLabel()
        setConstraintsNoInternetImageView()
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
            noInternetImageView.isHidden = true
        case .noInternet:
            titleLabel.text = "No Internet connection!"
            descriptionLabel.text = "Please check your internet connection."
            virusOneImageView.isHidden = true
            virusTwoImageView.isHidden = true
            virusThreeImageView.isHidden = true
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
    
    func setConstraintsTryAgainButton() {
        tryAgainButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).dividedBy(3)
            make.height.equalTo(44)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
}
