
import Foundation

struct StatsDomainItemDetail {
    
    var name: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    var confirmed: Int = -1
    var active: Int = -1
    var recovered: Int = -1
    var deaths: Int = -1
    
    init(name: String = "", lat: Double = 0.0, lng: Double = 0.0, confirmed: Int = -1, active: Int = -1, recovered: Int = -1, deaths: Int = -1) {
        self.name = name
        self.lat = lat
        self.lng = lng
        self.confirmed = confirmed
        self.active = active
        self.recovered = recovered
        self.deaths = deaths
    }
}
