
import Foundation

struct CountryStatus: Codable {
    
    var countryName, countryCode, slug: String
    var newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    var newRecovered, totalRecovered: Int
    

    enum CodingKeys: String, CodingKey {
        case countryName = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
