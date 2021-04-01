//
//  UserDefaultsService.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

enum DefaultsKey: String {
    case lastSelection
}

struct UserDefaultsService {
    private static let userDefaults = UserDefaults.standard
    
    static func saveLastSelection(_ selection: String) {
        userDefaults.set(selection, forKey: DefaultsKey.lastSelection.rawValue)
    }
    
    static func getLastSelection() -> String {
        let lastSelection = userDefaults.string(forKey: DefaultsKey.lastSelection.rawValue)
        return lastSelection ?? "croatia"
    }
    
}
