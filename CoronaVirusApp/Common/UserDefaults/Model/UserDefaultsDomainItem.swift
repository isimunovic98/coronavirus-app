//
//  UserDefaultsDomainItem.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 29.04.2021..
//

import Foundation

struct UserDefaultsDomainItem: Codable {
    
    var usecase: String = ""
    var details: [String] = .init()
    
    init(usecase: String = "", details: [String] = .init()) {
        self.usecase = usecase
        self.details = details
    }
}
