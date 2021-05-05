//
//  UserDefaults+Extensions.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 05.05.2021..
//

import Foundation

extension UserDefaults: ObjectSavable {
    
    func setCustomObject<T: Codable>(_ object: T, forKey: String) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getCustomObject<T: Codable>(forKey: String) throws -> T {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
