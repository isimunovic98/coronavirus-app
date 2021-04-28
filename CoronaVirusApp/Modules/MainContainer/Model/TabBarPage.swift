//
//  TabBarPage.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 11.04.2021..
//

import UIKit

enum TabBarPage: Int {
    case home
    case statistics
    case news
    case healthTips
    
    func getIcon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "HomeTabIcon")
        case .statistics:
            return UIImage(named: "StatisticsTabIcon")
        case .news:
            return UIImage(named: "LatestNewsTabIcon")
        case .healthTips:
            return UIImage(named: "HealthTipsTabIcon")
        }
    }

}
