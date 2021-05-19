//
//  StatisticsScreenCoordinatorDelegate.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 17.05.2021..
//

import Foundation
import MapKit

protocol StatisticsScreenCoordinatorDelegate {
    func openInAppleMaps(_ mapItem: MKMapItem, showing region: MKCoordinateRegion)
    func openCountrySelection()
}
