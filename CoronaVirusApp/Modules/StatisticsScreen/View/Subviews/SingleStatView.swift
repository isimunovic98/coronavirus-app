//
//  SingleStatView.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 08.05.2021..
//

import UIKit
import SnapKit

class SingleStatView: UIView {
    //MARK: Properties
    let statTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    let statCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
extension SingleStatView {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        #warning("color")
        backgroundColor = .white
    }
    
    func addViews() {
        stackView.addArrangedSubviews([statTagLabel, statCountLabel])
        addSubview(stackView)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
