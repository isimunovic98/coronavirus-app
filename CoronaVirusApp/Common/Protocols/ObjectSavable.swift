//
//  ObjectSavable.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 05.05.2021..
//

import Foundation

protocol ObjectSavable {
    func setCustomObject<Object: Codable>(_ object: Object, forKey: String) throws
    func getCustomObject<Object: Codable>(forKey: String) throws -> Object
}
