//
//  Office.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
import CoreLocation
class Office: NSObject, Identifiable {
    let id = UUID()
    var officeId: String
    var name: String
    var address: String
    var routeArray: [Route]
    var gps: CLLocation
    var canAdviseAt: Date?

    init(officeId: String, name: String, address: String, gps: CLLocation, routeArray: [Route]) {
        self.officeId = officeId
        self.name = name
        self.address = address
        self.gps = gps
        self.routeArray = routeArray
    }
    

}
