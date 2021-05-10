
import UIKit

class HomeScreenHeaderView: UIView {
    
    weak var delegate: CountrySelectionHandler?
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Covid-19 Tracker"
        label.textColor = .white
        return label
    }()
    
    let usecaseSelectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "COUNTRY SELECTION"
        label.textColor = .white
        label.font = label.font.withSize(30)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let usecaseSelectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = .systemGray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let lastTimeUpdateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Updated XYZ time ago.."
        label.font = label.font.withSize(12)
        label.textColor = .gray
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension HomeScreenHeaderView {
    
    func update(with data: HomeScreenDomainItem) {
        usecaseSelectionLabel.text = data.title
        lastTimeUpdateLabel.text = "Last updated \(DateUtils.getTimeElapsedSince(data.lastUpdateDate) ?? "") ago."
    }
    
    func setViews() {
        addSubviews([appTitleLabel, usecaseSelectionLabel, usecaseSelectionImageView, lastTimeUpdateLabel])
        usecaseSelectionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(countrySelectionTapped)))
        usecaseSelectionImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(countrySelectionTapped)))
    }
    
    @objc func countrySelectionTapped() { delegate?.openCountrySelection() }
    
    func setConstraints() {
        setConstraintsTitleLabel()
        setConstraintsUsecaseSelectionLabel()
        setConstraintsUsecaseSelectionImageView()
        setConstraintsLastTimeUpdateLabel()
    }
    
    func setConstraintsTitleLabel() {
        appTitleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(30)
        }
    }
    
    func setConstraintsUsecaseSelectionLabel() {
        usecaseSelectionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self)
            make.height.equalTo(44)
        }
    }
    
    func setConstraintsUsecaseSelectionImageView() {
        usecaseSelectionImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(10)
            make.centerY.equalTo(usecaseSelectionLabel)
            make.leading.equalTo(usecaseSelectionLabel.snp.trailing).offset(5)
        }
    }
    
    func setConstraintsLastTimeUpdateLabel() {
        lastTimeUpdateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usecaseSelectionLabel.snp.bottom).offset(5)
            make.bottom.leading.trailing.equalTo(self)
        }
    }
}
