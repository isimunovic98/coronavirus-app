//
//  CountrySelectionModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 03.05.2021..
//

import Foundation

struct CountrySelectionModel {
    var content: String?
    var icon: String?
    var cellType: CellType
    
    init(country: Country) {
        self.content = country.country
        self.icon = CountrySelectionModel.transformToFlagEmoji(iso: country.iso)
        self.cellType = .country
    }
    
    init(content: String?, cellType: CellType) {
        self.content = content
        self.icon = nil
        self.cellType = cellType
    }
    
    private static func transformToFlagEmoji(iso: String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in iso.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
}
