//
//  RestEndpoints.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation
import Cuckoo

public enum RestEndpoints: Matchable {
    
    static var scheme: String {
        return "https://"
    }
    static var host: String {
        return "api.covid19api.com"
    }
    
    static var ENDPOINT: String {
        return scheme + host
    }
    
    case countriesList
    
    case dayOneAllStatus
    
    case byCountryTotalStatus
    
    case summary
    
    public func endpoint() -> String {
        switch self {
        case .countriesList:
            return RestEndpoints.ENDPOINT + "/countries"
        case .dayOneAllStatus:
            return RestEndpoints.ENDPOINT + "/dayone/country/"
        case .byCountryTotalStatus:
            return RestEndpoints.ENDPOINT + "total/country/"
        case .summary:
            return RestEndpoints.ENDPOINT + "/summary"
        }
    }
}

