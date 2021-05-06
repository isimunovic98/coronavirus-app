
import Foundation

struct WorldwideResponseItem: Codable {
    var global: Global
    var countries: [CountryStatus]

    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}

