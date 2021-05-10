//
//  PaginationInformation.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 05.05.2021..
//

import Foundation

struct PaginationInformation: Codable {
    var limit: Int
    var offset: Int
    var count: Int
    var total: Int
}
