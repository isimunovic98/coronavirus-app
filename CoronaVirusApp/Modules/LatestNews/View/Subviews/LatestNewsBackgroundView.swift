//
//  LatestNewsMainView.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 28.04.2021..
//

import UIKit
import SnapKit

class LatestNewsBackgroundView: UIView {
    //MARK: Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Latest News"
        label.font = UIFont(name: "Montserrat", size: 30.0)
        label.sizeToFit()
        return label
    }()
    
    let virusImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusTopLeft
        imageView.alpha = 0.4
        return imageView
    }()
    
    let virusImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusImage
        imageView.alpha = 0.6
        return imageView
    }()

    let virusImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusTopRight
        imageView.alpha = 0.5
        return imageView
    }()

    let virusImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusBlurred
        imageView.alpha = 0.4
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - UI
extension LatestNewsBackgroundView {
    func setupView() {
        addViews()
        setupLayout()
    }
    
    func addViews() {
        let views = [titleLabel, virusImageView1, virusImageView2, virusImageView3, virusImageView4]
        addSubviews(views)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 44.0, left: 20.0, bottom: 0.0, right: 15.0))
        }
        
        virusImageView1.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.size.equalTo(45)
        }
        
        virusImageView2.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview().offset(30)
            make.size.equalTo(55)
        }
        
        virusImageView3.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
        }
        
        virusImageView4.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(100)
            make.trailing.equalToSuperview()
        }
    }
}
