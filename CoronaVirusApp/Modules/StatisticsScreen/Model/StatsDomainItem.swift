
import Foundation
import MapKit

struct StatsDomainItem {
    var screenTitle: String
    var cardTitle: String
    var confirmed: Int
    var active: Int
    var recovered: Int
    var deceased: Int
    var annotations: [MKPointAnnotation]
    var centerLatitude: Double?
    var centerLongitude: Double?
    
    init(screenTitle: String = "Statistics",
         cardTitle: String = "Unknown",
         confirmed: Int = 0,
         active: Int = 0,
         recovered: Int = 0,
         deceased: Int = 0,
         annotations: [MKPointAnnotation] = []) {
        
        self.screenTitle = screenTitle
        self.cardTitle = cardTitle
        self.confirmed = confirmed
        self.active = active
        self.recovered = recovered
        self.deceased = deceased
        self.annotations = annotations
    }
}
