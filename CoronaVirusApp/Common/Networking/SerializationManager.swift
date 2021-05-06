//
//  SerializationManager.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

public class SerializationManager {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()
    
    public static func parseData<T: Codable>(jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        return parseData(jsonData: jsonData)
    }
    
    static func parseData<T: Codable>(jsonData: Data) -> T? {
        let object: T?
        do { object = try jsonDecoder.decode(T.self, from: jsonData) }
        catch (_) { object = nil }
        return object
    }
}
