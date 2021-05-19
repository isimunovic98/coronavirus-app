//
//  LatestNewsViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 27.04.2021..
//

import UIKit
import Combine

class LatestNewsViewController: UIViewController, LoadableViewController, ErrorableViewController {
    var loaderOverlay: LoaderOverlay
    let viewModel: LatestNewsViewModel
    var disposeBag = Set<AnyCancellable>()
    
    //MARK: Properties
    let backgroundView: LatestNewsBackgroundView = {
        let view = LatestNewsBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 12
        tableView.layer.masksToBounds = true
        return tableView
    }()
    
    //MARK: Init
    init(viewModel: LatestNewsViewModel) {
        self.viewModel = viewModel
        self.loaderOverlay = LoaderOverlay()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LatestNews VC deinit")
    }
}

//MARK: - Lifecycle
extension LatestNewsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

}

//MARK: - UI
extension LatestNewsViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupBindings()
        configureTableView()
    }
    
    func setupAppearance() {
        view.backgroundColor = .backgroundColorFirst
    }
    
    func addViews() {
        backgroundView.addSubview(tableView)
        view.addSubview(backgroundView)
    }
    
    func setupLayout() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.titleLabel.snp.bottom)
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0))
        }
    }
}

//MARK: - Bindings
private extension LatestNewsViewController {
    func setupBindings() {
        viewModel.initializeScreenData(with: viewModel.loadData).store(in: &disposeBag)
        
        initializeLoaderSubject(viewModel.loaderPublisher).store(in: &disposeBag)
        
        initializeErrorSubject(viewModel.errorSubject.eraseToAnyPublisher()).store(in: &disposeBag)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.tableView.reloadData()
                self?.tableView.removeSpinner()
            })
            .store(in: &disposeBag)
    }
}

//MARK: - Methods
extension LatestNewsViewController {
    func openWebView(of index: Int) {
        viewModel.openWebView(of: index)
    }
    
    func tryAgainAfterError() {
        viewModel.loadData.send(25)
    }
    
    func backToCountrySelection() { }
}

//MARK: - TableView Config
extension LatestNewsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.screenData[indexPath.row]
        
        let cell: LatestNewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.configure(with: article)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openWebView(of: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (viewModel.loadingInProgress){
            return
        }
        
        if (!viewModel.pagesAvailable) {
            return
        }
        
        let visibleIndexPaths = tableView.indexPathsForVisibleRows
        guard let lastVisibleIndex = visibleIndexPaths?.last else {
            return
        }
        
        if (lastVisibleIndex.row > (tableView.numberOfRows(inSection: 0)) - 5 && tableView.isDragging) {
            tableView.showSpinner()
            viewModel.loadData.send(25)
        }
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(LatestNewsTableViewCell.self, forCellReuseIdentifier: LatestNewsTableViewCell.reuseIdentifier)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
