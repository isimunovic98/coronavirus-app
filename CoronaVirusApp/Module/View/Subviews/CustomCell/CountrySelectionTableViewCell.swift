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
        flagLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(16)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

extension CountrySelectionTableViewCell {
    func configure(with country: Country) {
        let countryISO = country.iso
        let countryName = country.country
        
        flagLabel.text = flag(country: countryISO)
        countryNameLabel.text = countryName
    }
    
    func flag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
}
