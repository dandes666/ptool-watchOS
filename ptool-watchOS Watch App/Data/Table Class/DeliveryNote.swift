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
    var pocList: [ReportPocInfo] = []
    var userAdvicedAt: Date? = nil
    
    init(adviceId: String, desc: String?, gps: CLLocation, pocList: [ReportPocInfo]) {
        self.deliveryNoteId = adviceId
        self.pocList = pocList
        if let d = desc {
            self.desc = d
        } else {
            self.desc = ""
        }
        self.gps = gps
    }
    init(dictionaryFormat: NSDictionary) {
        if let deliveryNoteId = dictionaryFormat["deliveryNoteId"] as? String {
            self.deliveryNoteId = deliveryNoteId
        } else {
            self.deliveryNoteId = ""
        }
        if let desc = dictionaryFormat["desc"] as? String {
            self.desc = desc
        } else {
            self.desc = ""
        }
        if let gps = dictionaryFormat["gps"] as? NSDictionary {
            if let lat = gps["lat"] as? Double {
                if let long = gps["long"] as? Double {
                    self.gps = CLLocation(latitude: lat, longitude: long)
                } else { self.gps = CLLocation(latitude: 46.826, longitude: -71.169) }
            } else { self.gps = CLLocation(latitude: 46.826, longitude: -71.169) }
        } else {
            self.gps = CLLocation(latitude: 46.826, longitude: -71.169)
        }
        if let pocList = dictionaryFormat["pocList"] as? NSArray {
            self.pocList = pocList.map { (re) -> ReportPocInfo in
                if let r = re as? NSDictionary {
                    return ReportPocInfo(dictionaryFormat: r)
                } else {
                    return ReportPocInfo(pocId: "")
                }
            }
        } else {
            self.pocList = []
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "deliveryNoteId": self.deliveryNoteId,
            "desc": self.desc,
            "gps": [
                "lat": self.getGpsLat(),
                "long": self.getGpsLong()
            ],
//            "imageList": imageList.map { $0.getDictionaryFormat() },
            "pocList": pocList.map { $0.getDictionaryFormat() }
        ]
    }
    func getGpsLat() -> Double {
//        if let gps = self.gps {
        return gps.coordinate.latitude
//        } else {
//            return 0
//        }
    }
    func getGpsLong() -> Double {
//        if let gps = self.gps {
        return gps.coordinate.longitude
//        } else {
//            return 0
//        }
    }
}

