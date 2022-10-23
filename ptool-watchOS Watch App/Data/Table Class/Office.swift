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

    init(officeId: String, name: String, address: String, gps: CLLocation, routeArray: [Route]) {
        self.officeId = officeId
        self.name = name
        self.address = address
        self.gps = gps
        self.routeArray = routeArray
    }
//    init(officeId: String, name: String, address: String, routeArray: [Route]) {
//        self.officeId = officeId
//        self.name = name
//        self.address = address
//        self.routeArray = routeArray
//    }
//    func addRoute(route: Route) {
//        self.routeArray += route
//    }

}
