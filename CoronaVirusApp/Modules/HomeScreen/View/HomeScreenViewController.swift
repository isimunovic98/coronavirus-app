
import UIKit
import Combine

class HomeScreenViewController: UIViewController, LoadableViewController {
   
    var viewModel: HomeScreenViewModel
    var disposeBag = Set<AnyCancellable>()
    var loaderOverlay: LoaderOverlay
    
    let mainView: HomeScreenMainView = {
        let view = HomeScreenMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        self.loaderOverlay = .init()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    deinit { print("HomeScreenViewController deinit called.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setConstraintsMainView()
        setViewModelSubscribers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        viewModel.fetchScreenDataSubject.send(UserDefaultsService.getUsecase())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        if isMovingFromParent { viewModel.coordinator?.viewControllerDidFinish() }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.middleView.addShadows()
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenData.details.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HomeScreenTableViewHeaderCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(for: UserDefaultsService.getUsecase())
            return cell
        }
        else {
            let cell: HomeScreenTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel.screenData.details[indexPath.row - 1])
            return cell
        }
    }
}

extension HomeScreenViewController: ErrorableViewController {
    func tryAgainAfterError() { viewModel.fetchScreenDataSubject.send(UserDefaultsService.getUsecase()) }
    
    func backToCountrySelection() { viewModel.openCountrySelection() }
}

extension HomeScreenViewController: CountrySelectionHandler {
    func openCountrySelection() { viewModel.openCountrySelection() }
}

extension HomeScreenViewController {
    
    func setViewModelSubscribers() {
        viewModel.initializeFetchScreenDataSubject(viewModel.fetchScreenDataSubject)
            .store(in: &disposeBag)
        viewModel.updateScreenSubject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [unowned self] (_) in
                self.updateSubviews(with: self.viewModel.screenData)
            }
            .store(in: &disposeBag)
        initializeLoaderSubject(viewModel.loaderPublisher)
            .store(in: &disposeBag)
        initializeErrorSubject(viewModel.errorSubject.eraseToAnyPublisher())
            .store(in: &disposeBag)
    }
    
    func updateSubviews(with data: HomeScreenDomainItem) {
        mainView.updateSubviews(with: data)
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "themeColorWithDarkMode")
        view.addSubview(mainView)
        mainView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    func setConstraintsMainView() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
