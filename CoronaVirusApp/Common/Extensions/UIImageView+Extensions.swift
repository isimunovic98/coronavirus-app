//
//  UIImageView+Extensions.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let cacheImage = ImageCache.default.retrieveImageInMemoryCache(forKey: urlString)
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        self.kf.setImage(with: resource, placeholder: cacheImage, options: [.keepCurrentImageWhileLoading])
    }
}
