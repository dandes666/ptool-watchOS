//
//  DeliveryNote.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import Foundation
class DeliveryNote: NSObject {
//    DeliveryNote
    var deliveryNoteId: String
    var desc: String
    var pocArray: [ReportPocInfo] = []
    
    init(adviceId: String) {
        self.deliveryNoteId = adviceId
        self.desc = ""
    }
}

