import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage (with value: String?) {
        guard let imagePath = value else { return }
        guard let url = URL(string: imagePath) else { return }
        self.kf.setImage(with: url)
    }
}
