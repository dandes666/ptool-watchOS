//
//  Report.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
import CoreLocation

class Report: NSObject {
    var reportId: String
    var name: String
    var type: String
    var proximityAlert: Bool
    var gps: CLLocation
    var imageList: [ReportImage]
    var note: [ReportNote]
    var pocList: [ReportPocInfo]
    var securedistance: Int
    var status: Int
    
    init(reportId: String, name: String ,type: String, proximityAlert: Bool, gps: CLLocation, imageList: [ReportImage], note: [ReportNote], pocList: [ReportPocInfo], securedistance: Int, status: Int) {
        self.reportId = reportId
        self.name = name
        self.type = type
        self.proximityAlert = proximityAlert
        self.gps = gps
        self.imageList = imageList
        self.note = note
        self.pocList = pocList
        self.securedistance = securedistance
        self.status = status
    }

}
