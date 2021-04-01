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
    case connectionTimedOut
    case notConnectedToInternet
    case networkConnectionLost
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseFailed:
            return "Parse failed"
        case .generalError:
            return "Something went wrong, please try again"
        case .connectionTimedOut:
            return "Connection timed out, try again later"
        case .notConnectedToInternet:
            return "You are not connected to internet, check your connection and try again"
        case .networkConnectionLost:
            return "Lost connection to server, try again later"
        }
    }
}
