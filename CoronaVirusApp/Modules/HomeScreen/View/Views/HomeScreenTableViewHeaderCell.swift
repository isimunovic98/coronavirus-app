
import UIKit

class HomeScreenTableViewHeaderCell: UITableViewCell {
    
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
        label.textColor = .black
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_HeaderCell
        label.numberOfLines = 0
        return label
    }()
    
    let confirmedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemRed
        label.text = "C"
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_HeaderCell
        return label
    }()
    
    let activeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemBlue
        label.text = "A"
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_HeaderCell
        return label
    }()
    
    let recoveredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .systemGreen
        label.text = "R"
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_HeaderCell
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .gray
        label.text = "D"
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.backgroundColor = .backgroundColor_HeaderCell
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

extension HomeScreenTableViewHeaderCell {
    
    func configure(for value: UseCaseSelection?) {
        guard let usecase = value else { return }
        switch usecase {
        case .country(_): titleLabel.text = "Date"
        case .worldwide: titleLabel.text = "State"
        }
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
