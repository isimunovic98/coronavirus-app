
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
        label.font = label.font.withSize(30)
        return label
    }()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsView: StatsCardView = {
        let view = StatsCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundColorSecond
        return view
    }()
    
    let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = UIColor(named: "BackgroundColor")
        return stackView
    }()
    
    init(viewModel: StatisticsScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    deinit { print("StatsScreenViewController deinit called.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        viewModel.updateUsecase()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statsView.addShadow(color: .black)
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
        view.backgroundColor = .backgroundColorFirst
    }
    
    func addViews() {
        containerView.addArrangedSubviews([titleLabel, mapView, statsView])
        view.addSubview(containerView)
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(mapView.snp.width)
        }

        statsView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(statsView.snp.width).dividedBy(2.2)
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
            .sink(receiveValue: { [unowned self] usecase in
                self.updateView(basedOn: usecase)
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
        switch viewModel.usecase {
        case .country:
            guard let annotation = viewModel.screenData.annotations.first else {
                break
            }
            mapView.deselectAnnotation(annotation, animated: false)
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        viewModel.annotationDeselected()
    }
}

//MARK: - Methods
extension StatistiscScreenViewController {
    
    private func updateView(basedOn usecase: UseCaseSelection) {
        let screenData = viewModel.screenData
        titleLabel.text = screenData.screenTitle
        statsView.configure(with: screenData)
        
        switch usecase {
        case .country:
            updateViewForCountryStatistics(using: screenData)
        default:
            if viewModel.zoomToCountry {
                zoomToCountry(using: screenData)
            } else {
                updateViewForWorldwideStatistics(using: screenData)
            }
        }
    }

    private func updateViewForCountryStatistics(using screenData: StatsDomainItem) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(screenData.annotations)
        guard let centerLat = screenData.centerLatitude,
              let centerLon = screenData.centerLongitude else {return}
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: viewModel.singleLocationRadius, longitudinalMeters: viewModel.singleLocationRadius), animated: true)
    }
    
    private func updateViewForWorldwideStatistics(using screenData: StatsDomainItem) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.showAnnotations(screenData.annotations, animated: true)
    }
    
    private func zoomToCountry(using screenData: StatsDomainItem) {
        guard let centerLat = screenData.centerLatitude,
              let centerLon = screenData.centerLongitude else {return}
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: viewModel.singleLocationRadius, longitudinalMeters: viewModel.singleLocationRadius), animated: true)
    }
    
    func tryAgainAfterError() {
        viewModel.updateUsecase()
    }
    
    func backToCountrySelection() { }
}
