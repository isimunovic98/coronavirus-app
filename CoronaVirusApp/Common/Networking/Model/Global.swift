import Foundation

struct Global: Codable {
    var newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    var newRecovered, totalRecovered: Int

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
