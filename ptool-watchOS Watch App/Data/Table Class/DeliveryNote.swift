//
//  DeliveryNote.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import Foundation
import CoreLocation

class DeliveryNote: NSObject {
//    DeliveryNote
    var deliveryNoteId: String
    var desc: String
    var gps: CLLocation
    var pocArray: [ReportPocInfo] = []
    var userAdvicedAt: Date? = nil
    
    init(adviceId: String, desc: String?, gps: CLLocation) {
        self.deliveryNoteId = adviceId
        self.desc = ""
        self.gps = gps
    }
}

