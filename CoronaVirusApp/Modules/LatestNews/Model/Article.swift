//
//  Article.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 05.05.2021..
//

import Foundation

struct Article: Codable {
    var title: String
    var description: String
    var url: String
    var source: String
    var imageUrl: String?
    var publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case url = "url"
        case source = "source"
        case imageUrl = "image"
        case publishedAt = "published_at"
    }
}
