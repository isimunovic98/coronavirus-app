//
//  CountryResponseModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation

struct Country: Codable {
    var country: String
    var slug: String
    var iso: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso = "ISO2"
    }
}
