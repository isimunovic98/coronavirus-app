
import UIKit
import SnapKit

class StatsCardView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat", size: 20)
        label.font = label.font.withSize(20)
        return label
    }()

    let confirmedCasesView: SingleStatView = {
        let view = SingleStatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.statCountLabel.textColor = .systemRed
        view.statTagLabel.text = "COFIRMED"
        view.statCountLabel.text = "45"
        return view
    }()
    
    let activeCasesView: SingleStatView = {
        let view = SingleStatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.statCountLabel.textColor = .systemBlue
        view.statTagLabel.text = "ACTIVE"
        view.statCountLabel.text = "42"
        return view
    }()
    
    let recoveredCasesView: SingleStatView = {
        let view = SingleStatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.statCountLabel.textColor = .systemGreen
        view.statTagLabel.text = "RECOVERED"
        view.statCountLabel.text = "3"
        return view
    }()
    
    let deceasedCasesView: SingleStatView = {
        let view = SingleStatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.statCountLabel.textColor = .systemGray
        view.statTagLabel.text = "DECEASED"
        view.statCountLabel.text = "0"
        return view
    }()
    
    let firstRowStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    let secondRowStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
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
extension StatsCardView {
    
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func addViews() {
        firstRowStatsStackView.addArrangedSubviews([confirmedCasesView, activeCasesView])
        secondRowStatsStackView.addArrangedSubviews([recoveredCasesView, deceasedCasesView])
        containerStackView.addArrangedSubviews([titleLabel, firstRowStatsStackView, secondRowStatsStackView])
        addSubview(containerStackView)
    }
    
    func setupLayout() {
        containerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
    }

    func configure(with screenData: StatsDomainItem) {
        titleLabel.text = screenData.cardTitle
        confirmedCasesView.statCountLabel.text = NumberUtils.getCommaSeparatedNumber(screenData.confirmed)
        activeCasesView.statCountLabel.text =  NumberUtils.getCommaSeparatedNumber(screenData.active)
        recoveredCasesView.statCountLabel.text =  NumberUtils.getCommaSeparatedNumber(screenData.recovered)
        deceasedCasesView.statCountLabel.text =  NumberUtils.getCommaSeparatedNumber(screenData.deceased)
    }
}
