
import Foundation

class DateUtils {
    private static let DAY_S: Double = 24 * 60 * 60
    private static let MONTH_S: Double = DAY_S * 30
    private static let YEAR_S: Double = MONTH_S * 365
    
    static let articleDateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter
    }()
    
    static func getTextTime(date: Date) -> String {
        let currentDate = Date()
        let timeDifference = currentDate.timeIntervalSince(date) //get difference in seconds.
        let textTime: String
        
        switch timeDifference {
        case 0...3600:
            let timeInMinutes = (timeDifference / 60).rounded()
            if(timeInMinutes < 1){
                textTime = "just now"
                
            }else{
                textTime = "\(Int(timeInMinutes)) mins ago"
            }
            
        case 3600...DAY_S:
            let timeInHours = (timeDifference / (60 * 60)).rounded()
            textTime =  "\(Int(timeInHours)) hours ago"
            
        case DAY_S...DateUtils.MONTH_S:
            let days = (timeDifference / DAY_S).rounded()
            
            if(days == 1){
                textTime = "1 day ago"
            }else{
                textTime = "\(Int(days)) days ago"
            }
        case DateUtils.MONTH_S...DateUtils.YEAR_S:
            let months = (timeDifference / DateUtils.MONTH_S).rounded()
            
            if (months <= 4) {
                textTime = "1 month ago"
            } else {
                textTime = "\(Int(months)) months ago"
            }
            
        default:
            let years = (timeDifference / YEAR_S).rounded()
            if (years <= 4){
                textTime = "1 year ago"
            } else {
                textTime = "\(Int(years)) years ago"
            }
            
            
        }
        return textTime
    }

    static func calculateElapsedTime(since published: String) -> String {
        if let formatedDate = articleDateFormatter.date(from: published) {
            return getTextTime(date: formatedDate)
        } else {
            return ""
        }
    }
    
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
