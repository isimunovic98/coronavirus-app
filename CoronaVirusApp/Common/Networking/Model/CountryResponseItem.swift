
import Foundation

struct CountryResponseItem: Codable {
    var country: String
    var countryCode: String
    var lat: String
    var lon: String
    var confirmed, deaths, recovered, active: Int
    var date: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}
