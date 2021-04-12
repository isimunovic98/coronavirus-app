//
//  HeaderView.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 12.04.2021..
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    //MARK: Properties
    let worldIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🌎"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let worldwideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Worldwide"
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let horizontalDividor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        return view
    }()
    
    //MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
extension HeaderView {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        contentView.backgroundColor = .white
    }
    
    func addViews() {
        //let views = [flagImageView, countryNameLabel]
        stackView.addArrangedSubview(worldIconLabel)
        stackView.addArrangedSubview(worldwideLabel)
        contentView.addSubviews([stackView, horizontalDividor])
    }
    
    func setupLayout() {
        worldIconLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(16)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        horizontalDividor.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
}
