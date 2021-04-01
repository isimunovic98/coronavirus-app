//
//  CountrySelectionMainView.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit
import SnapKit

class CountrySelectionMainView: UIView {
    //MARK: Properties
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    let horizontalDividor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - UI
private extension CountrySelectionMainView {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        configureTableView()
    }
    
    func setupAppearance() {
        self.backgroundColor = .white
    }
    
    func addViews() {
        let views = [searchBar, horizontalDividor, tableView]
        self.addSubviews(views)
    }
    
    func setupLayout() {
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 32, bottom: 0, right: 32))
        }
        
        horizontalDividor.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalDividor.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32))
        }
    }
}

//MARK: - TableView Config
extension CountrySelectionMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = "Croatia"
        
        let cell: CountrySelectionTableViewCell = tableView.dequeue(for: indexPath)
        
        cell.configure(with: name)
        
        return cell
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(CountrySelectionTableViewCell.self, forCellReuseIdentifier: CountrySelectionTableViewCell.reuseIdentifier)
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
