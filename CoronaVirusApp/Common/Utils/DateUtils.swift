
import Foundation

class DateUtils {
    
    
    private static let regularDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    private static let relativeDateFormatter: RelativeDateTimeFormatter = {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.unitsStyle = .full
        return dateFormatter
    }()
    
    private static let isoDateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [ .withInternetDateTime, .withTimeZone ]
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    static func getRegularDate(from date: Date?) -> String? {
        guard let safedata = date else { return nil }
        return regularDateFormatter.string(from: safedata)
    }
    
    static func getISOFormattedDateString(from date: Date?) -> String? {
        guard let safeDate = date else { return nil }
        return isoDateFormatter.string(from: safeDate)
    }
    
    static func getISOFormattedDate(from string: String) -> Date? {
        return isoDateFormatter.date(from: string)
    }
    
    static func formateISO8601ToRegular(_ value: String) -> String? {
        return getRegularDate(from: getISOFormattedDate(from: value))
    }
    
    static func getTimeElapsedSince(_ date: Date?) -> String? {
        guard let safeDate = date else { return nil }
        // adds substring 'in ' to result string
        let result = relativeDateFormatter.localizedString(for: safeDate, relativeTo: Date())
        // start from 3. char removes 'in '
        let start = String.Index(utf16Offset: 3, in: result)
        let end = String.Index(utf16Offset: result.count, in: result)
        return String(result[start..<end])
    }
    
    static func getDomainDetailItemDate(from date: String) -> String? {
        return getRegularDate(from: getISOFormattedDate(from: date))
    }
    
}
