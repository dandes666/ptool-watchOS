//
//  Report.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import SwiftUI
import CoreLocation

//extension CLLocation {
//    /// Provide optional coordinate components labels
//    func locationString(with labels:[String]? = ["lat","lon"]) -> String {
//        return "\(latitudeString(with: labels!.first!))- \(longitudeString(with: labels!.last!))"
//    }
//
//    // Get string for each component
//    //This is not necessary, as you could combine this into formattedLabel: label
//    //But it's good to have these separate in case you need just one of the components
//    func latitudeString(with label: String?) -> String {
//        return "\(formattedLabel(from: label))\(self.coordinate.latitude)"
//    }
//
//    func longitudeString(with label: String?) -> String {
//        return "\(formattedLabel(from: label))\(self.coordinate.longitude)"
//    }
//
//    // Returns formatted label or nothing in case nothing is needed
//    func formattedLabel(from label: String?) -> String {
//        var sortedLabel = ""
//        if label != nil {
//            sortedLabel = "\(label!): "
//        }
//        return sortedLabel
//    }
//}
class Report: NSObject, Identifiable {
    var reportId: String
//    var id: String
    let id = UUID()
    var name: String?
    var desc: String?
    var type: String?
    var proximityAlert: Bool
    var gps: CLLocation
    var imageList: [ReportImage]
    var note: [ReportNote]
    var pocList: [ReportPocInfo]
    var securedistance: Double?
    var status: Int?
    var userAdvicedAt: Date? = nil
    
    init(reportId: String) {
        self.reportId = reportId
        self.name = nil
        self.desc = nil
        self.type = nil
        self.proximityAlert = false
        self.gps = CLLocation(latitude: 46.826, longitude: -71.169)
        self.imageList = []
        self.note = []
        self.pocList = []
        self.securedistance = nil
        self.status = nil
    }
    init(reportId: String, name: String?, desc: String?, type: String?, status: Int?, gps: CLLocation, proximityAlert: Bool?, imageList: [ReportImage]?, note: [ReportNote]?, pocList: [ReportPocInfo]?, securedistance: Double?) {
        self.reportId = reportId
        if let n = name {
            self.name = n
        } else {
            self.name = nil
        }
        if let d = desc {
            self.desc = d
        } else {
            self.desc = nil
        }
        if let t = type {
            self.type = t
        } else {
            self.type = nil
        }
        self.gps = gps
//        if let g = gps {
//            self.gps = g
//        } else {
//            self.gps = nil
//        }
        if let pa = proximityAlert {
            self.proximityAlert = pa
        } else {
            self.proximityAlert = false
        }
        if let il = imageList {
            self.imageList = il
        } else {
            self.imageList = []
        }
        if let no = note {
            self.note = no
        } else {
            self.note = []
        }
        if let pl = pocList {
            self.pocList = pl
        } else {
            self.pocList = []
        }
        if let sd = securedistance {
            self.securedistance = sd
        } else {
            self.securedistance = nil
        }
        if let pl = pocList {
            self.pocList = pl
        } else {
            self.pocList = []
        }
        if let sta = status {
            self.status = sta
        } else {
            self.status = nil
        }
    }
    init(dictionaryFormat: NSDictionary) {
        if let reportId = dictionaryFormat["reportId"] as? String {
            self.reportId = reportId
        } else {
            self.reportId = ""
        }
        if let name = dictionaryFormat["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let desc = dictionaryFormat["desc"] as? String {
            self.desc = desc
        } else {
            self.desc = ""
        }
        if let type = dictionaryFormat["type"] as? String {
            self.type = type
        } else {
            self.type = ""
        }
        if let proximityAlert = dictionaryFormat["proximityAlert"] as? Bool {
            self.proximityAlert = proximityAlert
        } else {
            self.proximityAlert = false
        }
        if let gps = dictionaryFormat["gps"] as? NSDictionary {
            if let lat = gps["lat"] as? Double {
                if let long = gps["long"] as? Double {
                    self.gps = CLLocation(latitude: lat, longitude: long)
                } else { self.gps = CLLocation(latitude: 46.826, longitude: -71.169) }
            } else { self.gps = CLLocation(latitude: 46.826, longitude: -71.169) }
        } else { self.gps = CLLocation(latitude: 46.826, longitude: -71.169) }
        if let status = dictionaryFormat["status"] as? Int {
            self.status = status
        } else {
            self.status = 0
        }
        if let imageList = dictionaryFormat["imageList"] as? NSArray {
            self.imageList = imageList.map { (re) -> ReportImage in
                if let r = re as? NSDictionary {
                    return ReportImage(dictionaryFormat: r)
                } else {
                    return ReportImage(url: "", fullPath: "", isPrimary: false)
                }
            }
        } else {
            self.imageList = []
        }
        if let note = dictionaryFormat["note"] as? NSArray {
            self.note = note.map { (re) -> ReportNote in
                if let r = re as? NSDictionary {
                    return ReportNote(dictionaryFormat: r)
                } else {
                    return ReportNote(note: "")
                }
            }
        } else {
            self.note = []
        }
        if let pocList = dictionaryFormat["pocList"] as? NSArray {
            self.pocList = pocList.map { (re) -> ReportPocInfo in
                if let r = re as? NSDictionary {
                    return ReportPocInfo(dictionaryFormat: r)
                } else {
                    return ReportPocInfo(dictionaryFormat: NSDictionary())
                }
            }
        } else {
            self.pocList = []
        }
    }
    
    func title() -> String {
        if let name = self.name {
            return name
        } else if let type = self.type {
            return type
        } else if let desc = self.desc {
            return desc
        } else {
            return self.reportId
        }
    }
    func getReportTypeTitle() -> String {
        if let t = self.type {
            switch t {
            case "dog":
                return NSLocalizedString("dog", comment: "")
            case "ice":
                return NSLocalizedString("ice", comment: "")
            case "brokenstep":
                return NSLocalizedString("brokenstep", comment: "")
            default:
                return NSLocalizedString("defaultType", comment: "")
            }
        } else {
            return NSLocalizedString("not defined", comment: "")
        }
    }
    func getReportNotificationTitle() -> String {
        if let t = self.type {
            switch t {
            case "dog":
                return NSLocalizedString("dog", comment: "")
            case "ice":
                return NSLocalizedString("ice", comment: "")
            case "brokenstep":
                return NSLocalizedString("brokenstep", comment: "")
            default:
                return NSLocalizedString("defaultType", comment: "")
            }
        } else {
            return NSLocalizedString("Alert de Proximite", comment: "")
        }
    }
    func getReportNotificationSubTitle() -> String {
        if pocList.count > 0 {
            return pocList[0].address
        } else {
            if let t = self.type {
                switch t {
                case "dog":
                    return NSLocalizedString("dog", comment: "")
                case "ice":
                    return NSLocalizedString("ice", comment: "")
                case "brokenstep":
                    return NSLocalizedString("brokenstep", comment: "")
                default:
                    return NSLocalizedString("defaultType", comment: "")
                }
            } else {
                return NSLocalizedString("not defined", comment: "")
            }
        }
    }
    func getReportImageName () -> String {
        if let t = self.type {
            switch t {
            case "dog":
                return "pawprint.fill"
            case "ice":
                return "snowflake"
            case "brokenstep":
                return "figure.stair.stepper"
            default:
                return "exclamationmark.triangle.fill"
            }
        } else {
            return "exclamationmark.triangle.fill"
        }
    }
    func getReportImageColor () -> Color {
        if let t = self.type {
            switch t {
            case "dog":
                return .red
            case "ice":
                return .red
            case "brokenstep":
                return .red
            default:
                return .red
            }
        } else {
            return .red
        }
    }
    func getName() -> String {
        if let name = self.name {
            return name
        } else {
            return ""
        }
    }
    func getDesc() -> String {
        if let desc = self.desc {
            return desc
        } else {
            return ""
        }
    }
    func getType() -> String {
        if let type = self.type {
            return type
        } else {
            return ""
        }
    }
    func getStatus() -> Int {
        if let status = self.status {
            return status
        } else {
            return 0
        }
    }
    func getGpsLat() -> Double {
        return self.gps.coordinate.latitude

    }
    func getGpsLong() -> Double {
        return self.gps.coordinate.longitude

    }
    func getSecuredistance() -> Double {
        if let securedistance = self.securedistance {
            return securedistance
        } else {
            return 0
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "reportId": reportId,
            "name": getName(),
            "desc": getDesc(),
            "type": getType(),
            "proximityAlert": self.proximityAlert,
            "gps": [
                "lat": self.getGpsLat(),
                "long": getGpsLong()
            ],
            "status": getStatus(),
            "imageList": imageList.map { $0.getDictionaryFormat() },
            "note": note.map { $0.getDictionaryFormat() },
            "pocList": pocList.map { $0.getDictionaryFormat() },
            "securedistance": self.getSecuredistance(),
        ]
    }
    
    func string () -> String {
        return "name= \(getName()) type= \(getType()) desc= \(getDesc())"
    }

}
