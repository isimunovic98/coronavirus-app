//
//  UIViewController+Extensions.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

extension UIViewController {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.view.addSubview(view)
        }
    }
}
