//
//  UIStackView+Extensions.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 02.04.2021..
//

import UIKit

extension UIStackView {
    func addArangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
