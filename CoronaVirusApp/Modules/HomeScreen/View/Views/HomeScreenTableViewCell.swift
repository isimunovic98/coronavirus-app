
import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .systemGray3
        label.numberOfLines = 0
        return label
    }()
    
    let confirmedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .systemGray3
        return label
    }()
    
    let activeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .systemGray3
        return label
    }()
    
    let recoveredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .systemGray3
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .systemGray3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenTableViewCell {
    
    func configureAsFirstCell(for value: UseCaseSelection?) {
        guard let usecase = value else { return }
        switch usecase {
        case .country(_): titleLabel.text = "Date"
        case .worldwide: titleLabel.text = "State"
        }
        confirmedLabel.textColor = .systemRed
        confirmedLabel.text = "C"
        activeLabel.textColor = .systemBlue
        activeLabel.text = "A"
        recoveredLabel.textColor = .systemGreen
        recoveredLabel.text = "R"
        deathsLabel.textColor = .systemGray
        deathsLabel.text = "D"
    }
    
    func configure(with info: HomeScreenDomainItemDetail) {
        titleLabel.text = info.title
        confirmedLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.confirmed))"
        confirmedLabel.textColor = .systemGray
        activeLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.active))"
        activeLabel.textColor = .systemGray
        recoveredLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.recovered))"
        recoveredLabel.textColor = .systemGray
        deathsLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.deaths))"
        deathsLabel.textColor = .systemGray
    }
    
    
    func setupViews() {
        backgroundColor = UIColor.clear
        isOpaque = false
        contentView.backgroundColor = .clear
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews([titleLabel, confirmedLabel, activeLabel, recoveredLabel, deathsLabel])
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsets.init(top: 2.0, left: 0.0, bottom: 2.0, right: 0.0))
            make.height.equalTo(40)
        }
        confirmedLabel.snp.makeConstraints { (make) in make.width.equalTo(stackView).dividedBy(8) }
        activeLabel.snp.makeConstraints { (make) in make.width.equalTo(stackView).dividedBy(8) }
        recoveredLabel.snp.makeConstraints { (make) in make.width.equalTo(stackView).dividedBy(8) }
        deathsLabel.snp.makeConstraints { (make) in make.width.equalTo(stackView).dividedBy(8) }
    }
}
