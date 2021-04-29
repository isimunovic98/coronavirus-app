//
//  CountrySelectionViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit
import SnapKit
import Combine

class CountrySelectionViewController: UIViewController {
    let viewModel: CountrySelectionViewModel
    var disposeBag = Set<AnyCancellable>()
    
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
    
    let worldwideView: WorldwideView = {
        let view = WorldwideView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No results found"
        label.font = UIFont(name: "Montserrat", size: 16)
        label.textColor = .systemGray
        label.isHidden = true
        return label
    }()
    
    //MARK: Init
    init(viewModel: CountrySelectionViewModel) {
        self.viewModel = viewModel
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Choose your country"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.coordinatorDelegate?.viewControllerDidFinish()
    }
}

//MARK: - UI
private extension CountrySelectionViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupBindings()
        configureTableView()
        configureSearchBar()
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemGray6
    }
    
    func addViews() {
        let views = [searchBar, worldwideView, tableView, noResultsLabel]
        view.addSubviews(views)
    }
    
    func setupLayout() {
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 32, bottom: 0, right: 32))
        }
        
        worldwideView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(worldwideView.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32))
        }
        
        noResultsLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(tableView)
        }
    }
}

//MARK: - Bindings
extension CountrySelectionViewController {
    func setupBindings() {
        worldwideView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleWorldwideTap)))
        
        viewModel.initializeScreenData(with: viewModel.loadData).store(in: &disposeBag)
        
        viewModel.attachFilterListener(subject: viewModel.searchPublisher).store(in: &disposeBag)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.processSearchResult()
                self?.tableView.reloadData()
            })
            .store(in: &disposeBag)

        #warning("add error handling")
    
    }
}

//MARK: - Methods
private extension CountrySelectionViewController {
    @objc func handleWorldwideTap() {
        viewModel.update("worldwide")
        navigationController?.popViewController(animated: false)
    }
    
    func processSearchResult() {
        if viewModel.screenData.isEmpty {
            tableView.isHidden = true
            noResultsLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noResultsLabel.isHidden = true
        }
    }
}

//MARK: - TableView Config
extension CountrySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = viewModel.screenData[indexPath.row]
        
        let cell: CountrySelectionTableViewCell = tableView.dequeue(for: indexPath)
        
        cell.configure(with: country)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = viewModel.screenData[indexPath.row].country
        viewModel.update(selectedCountry.lowercased())
        navigationController?.popViewController(animated: false)
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

//MARK: - SearchBar Delegate
extension CountrySelectionViewController: UISearchBarDelegate {
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let input = searchBar.text else {
            return
        }
        viewModel.searchPublisher.send(input)
    }
}
