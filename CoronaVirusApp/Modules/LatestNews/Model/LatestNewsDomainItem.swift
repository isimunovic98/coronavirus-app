//
//  LatestNewsDomainItem.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 06.05.2021..
//

import Foundation

struct LatestNewsDomainItem: Codable {
    var title: String
    var description: String
    var url: String
    var source: String
    var imageUrl: String?
    var publishedAt: String
    
    init(with article: Article) {
        self.title = article.title
        self.description = article.description
        self.url = article.url
        self.source = article.source
        self.imageUrl = article.imageUrl
        self.publishedAt = DateUtils.calculateElapsedTime(since: article.publishedAt)
    }
}
