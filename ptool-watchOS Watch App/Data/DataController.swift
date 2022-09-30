//
//  DataController.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//
import Foundation
import CoreData
import CoreLocation


class DataController: ObservableObject {
    @Published var myGps: CLLocation?
    @Published var userInfo = User(isEmpty: true)
    @Published var officeArray: [Office] = []
    @Published var reportArray: [Report] = []
//    init() {
//        var userId = "testtest"
//        var empId = "testtest"
//        var fName = "testtest"
//        var lName  = "testtest"
//        var type = 0
//        var officeSelected = "testtest"
//        var routeSelected = "testtest"
//        self.userInfo = User(userId, empId, fName ,lName, type, officeSelected, routeSelected)
//        self.officeArray = []
//        self.reportArray = []
//
//    }
    func loadUserInfo(userInfo: User) {
        self.userInfo = userInfo
    }
    func loadOfficeArray(officeArray: [Office]) {
        self.officeArray = officeArray
    }
    func loadUserInfo(reportArray: [Report]) {
        self.reportArray = reportArray
    }
    func loadData(result: String) {
        print(result)
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

                        if let imageList = report["imageList"] as? NSArray {

                            for imagePath in imageList {
                                if let url = imagePath as? String {
                                    o.imageList += [ReportImage(url: url)]
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
                        if let securedistance = report["securedistance"] as? Int {
                            o.securedistance = securedistance
                        }
                        if let status = report["status"] as? Int {
                            o.status = status
                        }

                        self.reportArray += [o]
                        print(o.string())
                    }
                }
                
            }
//            self.loadOfficeArray(officeArray: offArray)
        }
        print(self.officeArray[0].name)
    }
//    func getReportSorted(from: CLLocation, ascending: Bool) -> NSArray {
//        return self.reportArray.sorted(by: <#T##(Report, Report) throws -> Bool#>)
//    }
}
