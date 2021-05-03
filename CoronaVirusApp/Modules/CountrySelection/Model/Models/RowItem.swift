//
//  CountrySelectionModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 03.05.2021..
//

import Foundation

class RowItem <ItemContent, ItemType>{
    var content: ItemContent
    var type: CellType
    
    init(content: ItemContent, type: CellType) {
        self.content = content
        self.type = type
    }
}
