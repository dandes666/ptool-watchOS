//
//  Report.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
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
    var id: String
    var name: String?
    var desc: String?
    var type: String?
    var proximityAlert: Bool
    var gps: CLLocation?
    var imageList: [ReportImage]
    var note: [ReportNote]
    var pocList: [ReportPocInfo]
    var securedistance: Double?
    var status: Int?
    var userAdvicedAt: Date? = nil
    
    init(reportId: String) {
        self.reportId = reportId
        self.id = reportId
        self.name = nil
        self.desc = nil
        self.type = nil
        self.proximityAlert = false
        self.gps = nil
        self.imageList = []
        self.note = []
        self.pocList = []
        self.securedistance = nil
        self.status = nil
    }
    init(reportId: String, name: String?, desc: String?, type: String?, status: Int?, gps: CLLocation?, proximityAlert: Bool?, imageList: [ReportImage]?, note: [ReportNote]?, pocList: [ReportPocInfo]?, securedistance: Double?) {
        self.reportId = reportId
        self.id = reportId
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
        if let g = gps {
            self.gps = g
        } else {
            self.gps = nil
        }
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
                return "Risque de Chien"
            case "ice":
                return "Risque de glace"
            case "brokenstep":
                return "Escalier endomagé"
            default:
                return "Zone Dangereuse"
            }
        } else {
            return "non défini"
        }
    }
    func getReportImageName () -> String {
        if let t = self.type {
            switch t {
            case "dog":
                return "Dog"
            case "ice":
                return "Ice"
            case "brokenstep":
                return "BrokenStep"
            default:
                return "Alert"
            }
        } else {
            return "Alert"
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
    func string () -> String {
        return "name= \(getName()) type= \(getType()) desc= \(getDesc())"
    }

}
