
import Foundation

struct CountryListResponseItem: Codable {
    var country: String
    var slug: String
    var iso: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso = "ISO2"
    }
}
