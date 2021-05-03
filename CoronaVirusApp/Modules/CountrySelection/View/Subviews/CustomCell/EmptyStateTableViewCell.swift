//
//  EmptyStateTableViewCell.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 03.05.2021..
//

import UIKit

class EmptyStateTableViewCell: UITableViewCell {

    //MARK: Properties
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No results found"
        label.font = UIFont(name: "Montserrat", size: 16)
        label.textColor = .systemGray
        return label
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
private extension EmptyStateTableViewCell {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        contentView.backgroundColor = .systemGray6
    }
    
    func addViews() {
        contentView.addSubview(noResultsLabel)
    }
    
    func setupLayout() {
        noResultsLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
}

