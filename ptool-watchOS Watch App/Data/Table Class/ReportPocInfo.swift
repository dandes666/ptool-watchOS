//
//  ReportPocInfo.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
class ReportPocInfo: NSObject {
    var pocId: String
    var address: String?
    

    init(pocId: String) {
        self.pocId = pocId
    }
//    init(officeId: String, name: String, address: String, routeArray: [Route]) {
//        self.officeId = officeId
//        self.name = name
//        self.address = address
//        self.routeArray = routeArray
//    }

}
