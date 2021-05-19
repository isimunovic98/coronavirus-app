
import UIKit

class HomeScreenBackgroundView: UIView {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundColorFirstDarkAppearance
        view.clipsToBounds = true
        return view
    }()
    
    let virus1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusImage
        imageView.alpha = 0.6
        return imageView
    }()
    
    let virus2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusImage
        imageView.alpha = 0.5
        return imageView
    }()
    
    let virus3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .virusImage
        imageView.alpha = 0.4
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension HomeScreenBackgroundView {
    
    func setViews() {
        addSubview(backgroundView)
            backgroundView.addSubviews([virus1ImageView, virus2ImageView, virus3ImageView])
    }
    
    func setConstraints() {
        let width = UIScreen.main.bounds.width
        setConstraintsBackgroundView()
        setConstraintsVirus1ImageView(width/4)
        setConstraintsVirus2ImageView(width/6)
        setConstraintsVirus3ImageView(width/9)
    }
    
    func setConstraintsBackgroundView() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func setConstraintsVirus1ImageView(_ value: CGFloat) {
        virus1ImageView.snp.makeConstraints { (make) in
            make.width.equalTo(value)
            make.height.equalTo(value)
            make.centerX.equalTo(self.snp.leading).offset(value * 1/5)
            make.centerY.equalTo(self.snp.bottom).offset(-value * 3/5)
        }
    }
    
    func setConstraintsVirus2ImageView(_ value: CGFloat) {
        virus2ImageView.snp.makeConstraints { (make) in
            make.width.equalTo(value)
            make.height.equalTo(value)
            make.centerX.equalTo(self.snp.trailing).offset(-value / 4)
            make.centerY.equalTo(self.snp.top).offset(value)
        }
    }
    
    func setConstraintsVirus3ImageView(_ value: CGFloat) {
        virus3ImageView.snp.makeConstraints { (make) in
            make.width.equalTo(value)
            make.height.equalTo(value)
            make.centerX.equalTo(self.snp.trailing).offset(-value * 2/3)
            make.centerY.equalTo(self.snp.bottom).offset(-value)
        }
    }
}
