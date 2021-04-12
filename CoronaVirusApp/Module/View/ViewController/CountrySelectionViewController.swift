//
//  CountrySelectionViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit
import SnapKit

class CountrySelectionViewController: UIViewController {
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CounrySelection VC deinit")
    }}

//MARK: - Life Cycle
extension CountrySelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - UI
private extension CountrySelectionViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        configureTableView()
    }
    
    func setupAppearance() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        let views = [searchBar, tableView]
        view.addSubviews(views)
    }
    
    func setupLayout() {
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 32, bottom: 0, right: 32))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32))
        }
    }
}

//MARK: - TableView Config
extension CountrySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = "Croatia"
        
        let cell: CountrySelectionTableViewCell = tableView.dequeue(for: indexPath)
        
        cell.configure(with: name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView

        return view
    }
    
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.register(CountrySelectionTableViewCell.self, forCellReuseIdentifier: CountrySelectionTableViewCell.reuseIdentifier)
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
