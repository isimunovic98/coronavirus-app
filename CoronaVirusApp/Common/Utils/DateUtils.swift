//
//  DateUtils.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 19.04.2021..
//

import Foundation

class DateUtils {
    
    static func elapsedTime(for lastUpdateDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let result = formatter.localizedString(for: lastUpdateDate, relativeTo: Date())   // adds string 'in ' to result string
        let start = String.Index(utf16Offset: 3, in: result)                    // start from 3 char removes 'in '
        let end = String.Index(utf16Offset: result.count, in: result)
        return String(result[start..<end])
    }
    
    static func formateISO8601(_ value: String, as formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: value) {
            dateFormatter.dateFormat = formate
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
