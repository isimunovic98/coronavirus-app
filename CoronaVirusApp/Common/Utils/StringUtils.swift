//
//  StringUtil.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 27.04.2021..
//

import Foundation

class StringUtils {
    static func transformToSlug(_ value: String) -> String {
        return value.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}
