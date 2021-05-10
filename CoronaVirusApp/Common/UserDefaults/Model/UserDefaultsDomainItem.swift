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
        self.usecase = createSlug(from: usecase)
        self.details = details
    }
    
    private func createSlug(from value: String) -> String {
        return value.replacingOccurrences(of: " ", with: "-").lowercased()
    }
}


