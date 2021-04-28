//
//  RestEndpoints.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

public enum RestEndpoints {
    case countriesList
    
    case dayOneAllStatus(country: String)
    
    case byCountryTotalStatus(country: String)
    
    case summary
    
    case latestNews
    
    static let scheme = Bundle.main.object(forInfoDictionaryKey: "scheme") as! String
    
    static let covidHost = Bundle.main.object(forInfoDictionaryKey: "covidHost") as! String
    
    static let newsHost = Bundle.main.object(forInfoDictionaryKey: "newsHost") as! String

    static var ENDPOINT_COVID: String {
        return scheme + covidHost
    }

    static var ENDPOINT_NEWS: String {
        return scheme + newsHost
    }
    
    public func endpoint() -> String {
        switch self {
        case .countriesList:
            return RestEndpoints.ENDPOINT_COVID + "/countries"
        case .dayOneAllStatus(let country):
            return RestEndpoints.ENDPOINT_COVID + "/dayone/country/" + country
        case .byCountryTotalStatus(let country):
            return RestEndpoints.ENDPOINT_COVID + "/total/country/" + country
        case .summary:
            return RestEndpoints.ENDPOINT_COVID + "/summary"
        case .latestNews:
            return RestEndpoints.ENDPOINT_NEWS
        }
    }
}

