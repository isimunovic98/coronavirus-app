//
//  NavigationInformation.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 10.05.2021..
//

import Foundation
import MapKit

struct NavigationInformation {
    var country: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(country: String = "UNKNOWN", latitude: CLLocationDegrees = 0, longitude: CLLocationDegrees = 0) {
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
