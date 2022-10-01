//
//  Report.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
import CoreLocation

extension CLLocation {
    /// Provide optional coordinate components labels
    func locationString(with labels:[String]? = ["lat","lon"]) -> String {
        return "\(latitudeString(with: labels!.first!))- \(longitudeString(with: labels!.last!))"
    }

    // Get string for each component
    //This is not necessary, as you could combine this into formattedLabel: label
    //But it's good to have these separate in case you need just one of the components
    func latitudeString(with label: String?) -> String {
        return "\(formattedLabel(from: label))\(self.coordinate.latitude)"
    }

    func longitudeString(with label: String?) -> String {
        return "\(formattedLabel(from: label))\(self.coordinate.longitude)"
    }

    // Returns formatted label or nothing in case nothing is needed
    func formattedLabel(from label: String?) -> String {
        var sortedLabel = ""
        if label != nil {
            sortedLabel = "\(label!): "
        }
        return sortedLabel
    }
}
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
    var securedistance: Int?
    var status: Int?
    
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
    
    func string () -> String {
        return "name= \(String(describing: self.name)) type= \(String(describing: self.type)) desc= \(String(describing: self.desc))"
    }

}
