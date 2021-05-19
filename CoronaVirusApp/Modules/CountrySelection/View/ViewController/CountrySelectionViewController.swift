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
    let loaderOverlay = LoaderOverlay()
    
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        return tableView
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
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel.coordinatorDelegate?.viewControllerDidFinish()
        }
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
        view.backgroundColor = UIColor(named: "BackgroundColor")
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
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32))
        }
    }
    
    func setupNavigationBar() {
        title = "Choose your country"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor(named: "BackgroundColor")
        let backImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.backItem?.title = ""
    }
}

//MARK: - Bindings
extension CountrySelectionViewController: LoadableViewController, ErrorableViewController {
    
    func setupBindings() {
        initializeLoaderSubject(viewModel.loaderPublisher).store(in: &disposeBag)
        
        viewModel.initializeScreenData(with: viewModel.loadData).store(in: &disposeBag)
        
        initializeErrorSubject(viewModel.errorSubject.eraseToAnyPublisher()).store(in: &disposeBag)
        
        viewModel.attachFilterListener(subject: viewModel.searchPublisher).store(in: &disposeBag)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.tableView.reloadData()
            })
            .store(in: &disposeBag)
        initializeErrorSubject(viewModel.errorSubject.eraseToAnyPublisher())
            .store(in: &disposeBag)
    }
    
    func tryAgainAfterError() { viewModel.loadData.send(true) }
    func backToCountrySelection() { }
}

//MARK: - TableView Config
extension CountrySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.screenData[indexPath.row].cellType
        switch itemType {
        case .worldwide:
            let cell: WorldwideTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .country:
            let cell: CountryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let country = viewModel.screenData[indexPath.row]
            cell.configure(with: country)
            return cell
        case .emptyState:
            let cell: EmptyStateTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.screenData[indexPath.row]
        viewModel.update(selected.slug)
        navigationController?.popViewController(animated: false)
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
        tableView.register(WorldwideTableViewCell.self, forCellReuseIdentifier: WorldwideTableViewCell.reuseIdentifier)
        tableView.register(EmptyStateTableViewCell.self, forCellReuseIdentifier: EmptyStateTableViewCell.reuseIdentifier)
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
        guard let input = searchBar.text else { return }
        viewModel.searchPublisher.send(input)
    }
}
