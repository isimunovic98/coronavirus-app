//
//  NetworkError.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

public enum NetworkError: Error {
    case generalError
    case parseFailed
    case notConnectedToInternet
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseFailed:
            return "Parse failed"
        case .generalError:
            return "Something went wrong, please try again"
        case .notConnectedToInternet:
            return "You are not connected to internet, check your connection and try again"
        }
    }
}
