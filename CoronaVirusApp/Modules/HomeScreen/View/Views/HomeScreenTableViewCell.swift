
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
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_Cell
        label.numberOfLines = 0
        return label
    }()
    
    let confirmedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_Cell
        return label
    }()
    
    let activeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_Cell
        return label
    }()
    
    let recoveredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_Cell
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_Cell
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
    
    func configure(with info: HomeScreenDomainItemDetail) {
        titleLabel.text = info.title
        confirmedLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.confirmed))"
        activeLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.active))"
        recoveredLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.recovered))"
        deathsLabel.text = "\(NumberUtils.getPositiveNumberWithMetricPrefixSymbol(info.deaths))"
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
