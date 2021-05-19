
//
//  LatestNewsTableViewCell.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 30.04.2021..
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {
    //MARK: Properties
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont(name: "Montserrat", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont(name: "Montserrat", size: 12)
        label.font = label.font.withSize(12)
        return label
    }()
    
    let articleSourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 12)
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        return label
    }()
    
    let dotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    let articleTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 12)
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        return label
    }()
    
    let contentContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = .backgroundColorSecond
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    let footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    
    //MARK: Init
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
extension LatestNewsTableViewCell {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 12
    }
    
    func setupAppearance() {
        self.backgroundColor = .clear
        contentContainer.layer.borderColor = UIColor.gray.cgColor
        articleImageView.tintColor = .systemGray4
    }
    
    func addViews() {
        contentContainer.addSubviews([bodyStackView, footerStackView])
        bodyStackView.addArrangedSubviews([articleImageView, textStackView])
        textStackView.addArrangedSubviews([articleTitleLabel, articleDescriptionLabel])
        footerStackView.addArrangedSubviews([articleSourceLabel, dotView, articleTimeLabel])
        contentView.addSubview(contentContainer)
    }
    
    func setupLayout() {
        articleTimeLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        
        contentContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 30, bottom: 5, right: 30))
            make.height.greaterThanOrEqualTo(150)
        }
        
        bodyStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
            make.height.greaterThanOrEqualTo(120)
        }
        
        footerStackView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(bodyStackView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 12, bottom: 12, right: 12))
        }
        
        articleImageView.snp.makeConstraints { (make) in
            make.size.equalTo(75)
        }
        
        dotView.snp.makeConstraints { (make) in
            make.size.equalTo(3)
        }
    }
}

//MARK: - Methods
extension LatestNewsTableViewCell {
    func configure(with article: LatestNewsDomainItem) {
        self.articleImageView.setImage(from: article.imageUrl)
        self.articleTitleLabel.text = article.title
        self.articleDescriptionLabel.text = article.description
        self.articleSourceLabel.text = article.source
        self.articleTimeLabel.text = article.publishedAt
    }
}
