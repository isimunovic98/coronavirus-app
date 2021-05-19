
import UIKit
import SnapKit

class HomeScreenMainView: UIView {
    
    weak var delegate: CountrySelectionHandler?
    var tableViewHeightConstraint: Constraint?
    var scrollViewContentHeightConstraint: Constraint?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    let scrollViewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundView: HomeScreenBackgroundView = {
        let view = HomeScreenBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerView: HomeScreenHeaderView = {
        let view = HomeScreenHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleView: HomeScreenMiddleView = {
        let view = HomeScreenMiddleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
        tableView.register(HomeScreenTableViewHeaderCell.self, forCellReuseIdentifier: HomeScreenTableViewHeaderCell.reuseIdentifier)
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 5
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setAppearance()
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension HomeScreenMainView: CountrySelectionHandler {
    func openCountrySelection() { delegate?.openCountrySelection() }
}

extension HomeScreenMainView {
    
    func setAppearance() {
        backgroundColor = .backgroundColorFirst
    }
    
    func setViews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.addSubviews([backgroundView, headerView, middleView, tableView])
        headerView.delegate = self
    }
    
    func setConstraints() {
        setConstraintsScrollView()
        setConstraintsScrollViewContent()
        setConstraintsBackgroundView()
        setConstraintsHeaderView()
        setConstraintsMiddleView()
        setConstraintsTableView()
    }
    
    func updateSubviews(with data: HomeScreenDomainItem) {
        headerView.update(with: data)
        middleView.update(with: data)
        tableView.reloadData()
        setConstraintsTableViewHeight(to: calculateTableViewContentHeight())
        let newHeight = calculateScrollViewContentHeight()
        scrollView.contentSize = CGSize(width: self.frame.width, height: newHeight)
        setConstraintsScrollViewContentHeight(to: newHeight)
    }
    
    func calculateScrollViewContentHeight() -> CGFloat {
        let height = (backgroundView.frame.height - 50) +
            (middleView.frame.height + 20) +
            calculateTableViewContentHeight() + 100
        return CGFloat(height)
    }
    
    func calculateTableViewContentHeight() -> CGFloat {
        let height = tableView.contentSize.height
        return CGFloat(height)
    }
}

extension HomeScreenMainView {
    
    func setConstraintsScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
    func setConstraintsScrollViewContent() {
        scrollViewContent.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
        }
    }
    
    func setConstraintsBackgroundView() {
        backgroundView.snp.makeConstraints { (make) in
            make.top.width.equalTo(scrollView)
            make.height.equalTo(self).dividedBy(3)
            make.centerX.equalTo(scrollView)
        }
    }
    
    func setConstraintsHeaderView() {
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.centerX.equalTo(scrollView)
        }
    }
    
    func setConstraintsMiddleView() {
        middleView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(-50)
            make.width.equalToSuperview().dividedBy(1.2)
            make.centerX.equalTo(scrollView)
        }
    }
    
    func setConstraintsTableView() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(middleView.snp.bottom).offset(20)
            make.width.equalToSuperview().dividedBy(1.2)
            make.centerX.equalTo(scrollView)
        }
        setConstraintsTableViewHeight(to: 100)
    }
    
    func setConstraintsTableViewHeight(to newHeight: CGFloat) {
        if let constraint = tableViewHeightConstraint { constraint.deactivate() }
        tableView.snp.makeConstraints { (make) in tableViewHeightConstraint = make.height.equalTo(newHeight).constraint }
        layoutIfNeeded()
    }
    
    func setConstraintsScrollViewContentHeight(to newHeight: CGFloat) {
        if let constraint = scrollViewContentHeightConstraint { constraint.deactivate() }
        scrollViewContent.snp.makeConstraints { (make) in scrollViewContentHeightConstraint = make.height.equalTo(newHeight).constraint }
        layoutIfNeeded()
    }
}
