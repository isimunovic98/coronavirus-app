//
//  UserDefaultsDomainItem.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 29.04.2021..
//

import Foundation

struct UserDefaultsDomainItem: Codable {
    
    var usecase: String = ""
    
    init(usecase: String = "") {
        self.usecase = StringUtils.createSlug(from: usecase)
    }
}
