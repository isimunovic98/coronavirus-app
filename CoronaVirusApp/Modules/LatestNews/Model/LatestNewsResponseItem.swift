//
//  LatestNewsResponseItem.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 30.04.2021..
//

import Foundation

struct LatestNewsResponseItem: Codable {
    var paginationInformation: PaginationInformation
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case paginationInformation = "pagination"
        case articles = "data"
    }
}
