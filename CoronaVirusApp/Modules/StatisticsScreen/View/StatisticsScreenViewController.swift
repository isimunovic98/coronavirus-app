
import UIKit
import SnapKit
import MapKit
import Combine

class StatistiscScreenViewController: UIViewController, LoadableViewController, ErrorableViewController {
    //MARK: Properties
    var viewModel: StatisticsScreenViewModel
    var loaderOverlay = LoaderOverlay()
    var disposeBag = Set<AnyCancellable>()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(24)
        return label
    }()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(color: .systemGray)
        return view
    }()
    
    let statsView: StatsCardView = {
        let view = StatsCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(color: .systemGray)
        return view
    }()
    
    let containerView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    init(viewModel: StatisticsScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    deinit { print("StatsScreenViewController deinit called.") }
    
    override func viewDidLoad() {
        UserDefaultsService.update(UserDefaultsDomainItem(usecase: "croatia", details: []))
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - UI
extension StatistiscScreenViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupMapViewDelegate()
        setupBindings()
    }
    
    func setupAppearance() {
        #warning("color")
        view.backgroundColor = .white
    }
    
    func addViews() {
        containerView.addArrangedSubviews([titleLabel, mapView, statsView])
        view.addSubview(containerView)
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(32)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(mapView.snp.width)
        }

        statsView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(statsView.snp.width).dividedBy(2)
        }
    }
}

//MARK: - Bindings
extension StatistiscScreenViewController {
    func setupBindings() {
        viewModel.initializeFetchScreenDataSubject(viewModel.fetchScreenDataSubject)
            .store(in: &disposeBag)
        
        initializeLoaderSubject(viewModel.loaderPublisher).store(in: &disposeBag)
        
        initializeErrorSubject(viewModel.errorSubject.eraseToAnyPublisher()).store(in: &disposeBag)
        
        viewModel.screenDataReady
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] in
                self.updateSubviews()
            })
            .store(in: &disposeBag)
    }
}

extension StatistiscScreenViewController: MKMapViewDelegate {
    func setupMapViewDelegate() {
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.annotationSelected(view)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        viewModel.annotationDeselected()
    }
}

//MARK: - Methods
extension StatistiscScreenViewController {
    
    private func updateSubviews() {
        titleLabel.text = viewModel.screenData.screenTitle
        statsView.configure(with: viewModel.screenData)
        mapView.showAnnotations(viewModel.screenData.annotations, animated: true)
        guard let centerLat = viewModel.screenData.centerLatitude,
              let centerLon = viewModel.screenData.centerLongitude else {return}
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5)), animated: true)
        }
    
    func tryAgainAfterError() {
        guard let usecase = viewModel.usecase else { return }
        viewModel.fetchScreenDataSubject.send(usecase)
    }
}
