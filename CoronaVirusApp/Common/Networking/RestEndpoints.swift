//
//  RestEndpoints.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

public enum RestEndpoints {
    case countriesList
    case countryStats(countryName: String)
    case countryStatsTotal(countryName: String)
    case worldwideStats
    case latestNews(offset: Int)
    
    static let scheme = Bundle.main.object(forInfoDictionaryKey: "scheme") as! String
    static let covidHost = Bundle.main.object(forInfoDictionaryKey: "covidHost") as! String
    static let newsHost = Bundle.main.object(forInfoDictionaryKey: "newsHost") as! String
    static let newsAccessKey = Bundle.main.object(forInfoDictionaryKey: "newsAccessKey") as! String

    static var ENDPOINT_COVID: String { return scheme + covidHost }
    static var ENDPOINT_NEWS: String {
        return "http://" + newsHost + newsAccessKey
    }
    
    public func endpoint() -> String {
        switch self {
        case .countriesList:
            return RestEndpoints.ENDPOINT_COVID + "/countries"
        case .countryStats(let countryName):
            return RestEndpoints.ENDPOINT_COVID + "/dayone/country/" + countryName
        case .countryStatsTotal(let countryName):
            return RestEndpoints.ENDPOINT_COVID + "/total/country/" + countryName
        case .worldwideStats:
            return RestEndpoints.ENDPOINT_COVID + "/summary"
        case .latestNews(let offset):
            return RestEndpoints.ENDPOINT_NEWS + "&keywords=corona&sort=published_desc&languages=en&limit=25&offset=" + String(offset)
        }
    }
}

