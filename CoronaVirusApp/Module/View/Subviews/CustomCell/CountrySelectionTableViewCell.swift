//
//  TableViewCell.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

class CountrySelectionTableViewCell: UITableViewCell {
    //MARK: Properties
    let flagLabel: UILabel = {
        let imageView = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
private extension CountrySelectionTableViewCell {
    func setupView() {
        addViews()
        setupLayout()
    }
    
    func addViews() {
        //let views = [flagImageView, countryNameLabel]
        stackView.addArrangedSubview(flagLabel)
        stackView.addArrangedSubview(countryNameLabel)
        contentView.addSubview(stackView)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

extension CountrySelectionTableViewCell {
    func configure(with text: String) {
        flagLabel.text = NSLocalizedString("🇭🇷", comment: "")
        countryNameLabel.text = text
    }
}
