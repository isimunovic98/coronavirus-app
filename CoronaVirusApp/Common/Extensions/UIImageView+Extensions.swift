import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage (with value: String?) {
        guard let imagePath = value else { return }
        guard let url = URL(string: imagePath) else { return }
        self.kf.setImage(with: url)
    }
    
    func setImage(from url: String?) {
        guard let urlString = url else {
            self.image = UIImage(systemName: "photo.fill")
            return
        }
        guard let url = URL(string: urlString) else { return }
        let cacheImage = ImageCache.default.retrieveImageInMemoryCache(forKey: urlString)
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        self.kf.setImage(with: resource, placeholder: cacheImage, options: [.keepCurrentImageWhileLoading])
    }
}
