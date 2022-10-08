//
//  AppManager.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import Foundation
import CoreLocation
import Combine
import UserNotifications
import WatchKit
import SwiftUI

class AppManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
//    @Published var db = DataController()
    
    @Published var userInfo = User(isEmpty: true)
    @Published var officeArray: [Office] = []
    @Published var reportArray: [Report] = []
    @Published var alertReportArray: [Report] = []
    @Published var alertDeleveryNote: [DeliveryNote] = []
    @Published var deliveryNoteArray: [DeliveryNote] = []
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    @Published var guardianActive: Bool {
        willSet { objectWillChange.send() }
    }
    @Published var isPoximityReportActive: Bool {
        willSet { objectWillChange.send() }
    }
    @Published var isPoximityDeleveryNoteActive: Bool {
        willSet { objectWillChange.send() }
    }
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    override init() {
        self.guardianActive = true
        self.isPoximityReportActive = true
        self.isPoximityDeleveryNoteActive = true
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
            if success{
                print("All set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getReportById(reportId: String) -> Report? {
        if let report = reportArray.first(where: {$0.reportId == reportId}) {
            return report
           // do something with foo
        } else {
           return nil
        }
        
//        var r: Report?
//
//        ForEach(reportArray, id: \.self) { rep in
//            if (rep.reportId == reportId) {
//                r = rep
//            }
//        }
//        return r
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        //        print(#function, statusString)
    }
    func addAlert(report: Report?, note: DeliveryNote?) {
        print("Trace -> addAlert")
        if let r = report {
            r.userAdvicedAt = Date()
            alertReportArray += [r]
            sendReportProximityNotification(report: r)
        }
        if let n = note {
            n.userAdvicedAt = Date()
            deliveryNoteArray += [n]
        }
    }
    func cleanAlert() {
        
    }
    func verifPoximity () {
        if guardianActive == true {
            if let location = lastLocation {
                //  Verifier Les report
                if self.isPoximityReportActive {
//                    print("verifProximity Report")
                    for i in 0 ..< reportArray.count {
                        let r = reportArray[i]
                        if (r.proximityAlert == true && r.userAdvicedAt == nil) {
//                            if let gps = r.gps {
                                if let securedist = r.securedistance {
                                    if r.gps.distance(from: location) < securedist {
                                        addAlert(report: r, note: nil)
                                    } else {
//                                        print("Report id: \(r.reportId) sd: \(securedist) dist: \(gps.distance(from: location))")
                                    }
                                } else {
                                    //                            mettre une distance par default si pas de securdist
                                    if r.gps.distance(from: location) < 30 {
                                        addAlert(report: r, note: nil)
                                    } else {
//                                        print("Report id: \(r.reportId) dist: \(gps.distance(from: location))")
                                    }
                                }
//                            }
                        }
                    }
                }
                //  Verifier Les Notes
                if self.isPoximityDeleveryNoteActive {
                    for i in 0 ..< deliveryNoteArray.count {
                        let nt = deliveryNoteArray[i]
                        if let gps = nt.gps {
                            if gps.distance(from: location) < 30 {
                                addAlert(report: nil, note: nt)
                            } else {
                                //                            print("Note id: \(nt.deliveryNoteId) dist: \(nt.gps.distance(from: location))")
                            }
                        }
                    }
                }
//                print("verif Proximity FINISH")
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        lastLocation = location
        self.reportArray.sort {
            $0.gps.distance(from: location) < $1.gps.distance(from: location)
        }
//        self.deliveryNoteArray.sort {
//            $0.gps.distance(from: location) < $1.gps.distance(from: location)
//        }
//        print("trace receive new location lat:\(location.coordinate.latitude) lng:\(location.coordinate.longitude)")
        verifPoximity()
    }
    
    func loadResultData(result: NSDictionary) {
//        print(result)
        if let u = result["userInfo"] as? NSDictionary {
            
            if let userId = u["userId"] as? String {
                self.userInfo.userId = userId
            }
            if let empId = u["empId"] as? String {
                self.userInfo.empId = empId
            }
            if let fName = u["fName"] as? String {
                self.userInfo.fName = fName
            }
            if let lName = u["lName"] as? String {
                self.userInfo.lName = lName
            }
            if let userType = u["userType"] as? Int {
                self.userInfo.userType = userType
            }
            
            if let woData = u["watchOSData"] as? NSDictionary {
                if let officeId = woData["officeId"] as? String {
                    self.userInfo.officeSelected = officeId
                }
                if let routeId = woData["routeId"] as? String {
                    self.userInfo.routeSelected = routeId
                }
            }
        }
        if let u = result["officeInfo"] as? NSArray {
            self.officeArray = []
            for off in u {
                if let office = off as? NSDictionary {
                    if let officeId = office["officeId"] as? String {
                        if (officeId == self.userInfo.officeSelected) {
                            self.userInfo.officeIdx = self.officeArray.count
                        }
                        let o = Office(officeId: officeId)
                        if let address = office["address"] as? String {
                            o.address = address
                        }
                        if let oName = office["name"] as? String {
                            o.name = oName
                        }
                        if let rArray = office["routeInfo"] as? NSArray {
                            for rou in rArray {
                                if let route = rou as? NSDictionary {
                                    if let routeId = route["id"] as? String {
                                        if (routeId == self.userInfo.routeSelected) {
                                            self.userInfo.routeIdx = self.officeArray.count
                                        }
                                        let r = Route(routeId: routeId)
                                        if let rName = route["name"] as? String {
                                            r.setName(name: rName)
                                        }
                                        if let rType = route["type"] as? Int {
                                            r.setType(type: rType)
                                        }
                                        o.routeArray += [r]
                                    }
                                }
                                
                            }
                        }
                        self.officeArray += [o]
                    }
                }
                
            }
//            self.loadOfficeArray(officeArray: offArray)
        }
        if let u = result["reportList"] as? NSArray {
            self.reportArray = []
            for rep in u {
                if let report = rep as? NSDictionary {
                    if let reportId = report["id"] as? String {
                        let o = Report(reportId: reportId)
                        if let rName = report["name"] as? String {
                            o.name = rName
                        }
                        if let desc = report["desc"] as? String {
                            o.desc = desc
                        }
                        if let type = report["type"] as? String {
                            o.type = type
                        }
                        if let proximityAlert = report["proximityAlert"] as? Bool {
                            o.proximityAlert = proximityAlert
                        }
                        if let dangergps = report["dangergps"] as? NSDictionary {
                            if let lat = dangergps["_latitude"] {
                                if let lng = dangergps["_longitude"] {
                                    if let latitude = CLLocationDegrees(String(describing: lat)) {
                                        if let longitude = CLLocationDegrees(String(describing: lng)) {
                                            o.gps = CLLocation(latitude: latitude, longitude: longitude)
//                                            print(o.gps?.coordinate.latitude ?? 0)
//                                            print(o.gps?.coordinate.longitude ?? 0)
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
//                        print("trace")
                        
                        if let imageList = report["imageList"] as? NSArray {
//                            print(imageList)
                            for imageObj in imageList {
                                if let image = imageObj as? NSDictionary {

                                    if let url = image["url"] as? String {
//                                        print("path -> \(url)")
                                        if let fullPath = image["fullPath"] as? String {
                                            if let isPrimary = image["isPrimary"] as? Bool {
//                                                print("Trace 1")
                                                o.imageList += [ReportImage(url: url, fullPath: fullPath, isPrimary: isPrimary)]
                                            }
                                        }
                                        //                                    o.imageList += [ReportImage(url: url)]
                                    }
                                }
                            }
                        }
                        if let noteList = report["note"] as? NSArray {

                            for note in noteList {
                                if let t = note as? String {
                                    o.note += [ReportNote(note: t)]
                                }

                            }
                        }
                        if let pocList = report["pocList"] as? NSArray {

                            for poc in pocList {
                                if let p = poc as? NSDictionary {
                                    if let pocId = p["pocId"] as? String {
                                        let pocInfo = ReportPocInfo(pocId: pocId)
                                        if let add = p["address"] as? String {
                                            pocInfo.address = add
                                        }
                                        o.pocList += [pocInfo]
                                    }
                                }

                            }
                        }
                        if let securedistance = report["securedistance"] as? Double {
//                            print(securedistance)
                            o.securedistance = securedistance
                        }
                        if let status = report["status"] as? Int {
                            o.status = status
                        }

                        self.reportArray += [o]
//                        print(o.string())
                    }
                }
                
            }
//            self.loadOfficeArray(officeArray: offArray)
        }
//        print(self.officeArray[0].name)
        verifPoximity()
    }
    func sendReportProximityNotification(report: Report) {
        print("trace sendReportProximityNotification")
        let content = UNMutableNotificationContent()
        content.title = "Alerte de proximité"

        content.body = report.getReportTypeTitle()

        content.sound = .defaultCritical
//                content.sound = UNNotificationSound.
        content.categoryIdentifier = "reportProximityAlert"
        content.userInfo = [
//            "notifData": [
//                "reportId": report.reportId,
//                "name": report.getName(),
//                "desc": report.getDesc(),
//                "type": report.getType(),
//                "status": report.getStatus()
//            ],
            "reportDictionaryFormat": report.getDictionaryFormat(),
            "notificationType" : "reportProximityAlert"
        ]
        let category = UNNotificationCategory(identifier: "reportProximityAlert", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "reportProximityAlert", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("notification envoyer")
            }
        }
    }
}
