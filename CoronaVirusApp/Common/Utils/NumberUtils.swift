//
//  NumberUtils.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 05.05.2021..
//

import Foundation

class NumberUtils {
    private static let commaSeparatedFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveFormat = "###,###"
        numberFormatter.negativeFormat = "-###,###"
        numberFormatter.groupingSeparator = ","
        return numberFormatter
    }()
    
    static func getCommaSeparatedNumber(_ number: Int) -> String? {
        return commaSeparatedFormatter.string(from: number as NSNumber)
    }
    
    static func getPositiveNumberWithMetricPrefixSymbol (_ value: Int) -> String {
        switch value {
        case Int.min..<0:
            let positiveValue = abs(value)
            return getNumberWithMetricPrefixSymbol(positiveValue)
        default:
            return getNumberWithMetricPrefixSymbol(value)
        }
    }
    
    private static func getNumberWithMetricPrefixSymbol(_ value: Int) -> String {
        switch value {
        case 0..<1000: return "\(value)"
        case 1000..<1000000: return "\(value/1000)k"
        default: return "\(value/1000000)M"
        }
    }
}
