//
//  TableViewCell.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    //MARK: Properties
    let flagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
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
private extension CountryTableViewCell {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        contentView.backgroundColor = .systemGray6
    }
    
    func addViews() {
        stackView.addArrangedSubview(flagLabel)
        stackView.addArrangedSubview(countryNameLabel)
        contentView.addSubview(stackView)
    }
    
    func setupLayout() {
        flagLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(16)
        }

        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
}

//MARK: - Methods
extension CountryTableViewCell {
    func configure(with object: CountrySelectionModel) {
        flagLabel.text = object.icon
        countryNameLabel.text = object.content
    }
}
