
import Foundation

class StringUtils {
    static func createSlug(from string: String) -> String {
        return string.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}
