//
//  ObjectSavableError.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 29.04.2021..
//


import Foundation

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? { return rawValue }
}
