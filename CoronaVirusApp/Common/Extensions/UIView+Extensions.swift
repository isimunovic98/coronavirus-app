//
//  UIView+Extensions.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func addShadow(color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
    }


}
