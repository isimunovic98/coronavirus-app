//
//  UITableView+Extensions.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell> (for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else { fatalError("Unable to dequeue reusable table view cell.") }
        return cell
    }
    
    func showSpinner() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        self.tableFooterView = footerView
    }
    
    func removeSpinner() {
        self.tableFooterView = nil
    }
}
