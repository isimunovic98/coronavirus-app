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
        case .home:        return .homeTabIcon
        case .statistics:  return .statisticsTabIcon
        case .news:        return .latestNewsTabIcon
        case .healthTips:  return .healthTipsTabIcon
        }
    }
}
