//
//  UserDefaultsService.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

struct UserDefaultsService {
    static func update(_ item: UserDefaultsDomainItem) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(item.usecase, forKey: "usecase")
        do { try userDefaults.setCustomObject(item.details, forKey: "usecaseDetails") }
        catch (let error) { print(error.localizedDescription) }
    }
}
