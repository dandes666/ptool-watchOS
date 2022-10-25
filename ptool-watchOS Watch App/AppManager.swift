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
import Firebase
import FirebaseFunctions
import FirebaseCore
import FirebaseStorage


class AppManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let objectWillChange = PassthroughSubject<Void, Never>()
    private let locationManager = CLLocationManager()
    
//    private var firebaseAuth
    private var signInProcessing = false
    @Published var audioRecorder = AudioRecorder()
    @Published var currentPage: Page {
        willSet { objectWillChange.send() }
    }
    @Published var locationStatus: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    @Published var isLocationOk: Bool = false {
        willSet { objectWillChange.send() }
    }
    @Published var lastLocation: CLLocation?
//    @Published var db = DataController()
    
//    @Published var userInfo = User(isEmpty: true)
    @Published var userInfo: User {
        willSet { objectWillChange.send() }
    }
    @Published var officeArray: [Office] {
        willSet { objectWillChange.send() }
    }
    @Published var reportArray: [Report] {
        willSet { objectWillChange.send() }
    }
    @Published var memoArray: [Memo] = []  {
        willSet { objectWillChange.send() }
    }
    
    @Published var alertReportArray: [Report] = []
    @Published var alertDeleveryNote: [DeliveryNote] = []
    @Published var deliveryNoteArray: [DeliveryNote] = []
    
    @Published var currentTaskStatus: TaskStatus = .none {
        willSet { objectWillChange.send() }
    }
    @Published var currentTaskProgress: Double = 0 {
        willSet { objectWillChange.send() }
    }
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    @Published var guardianActive: Bool {
        willSet {
            objectWillChange.send()
            if newValue {
                if self.isPoximityReportActive {
//                    self.setReportNotificationAlert()
                }
                if self.isPoximityDeleveryNoteActive {
//                    self.setDeliveryNotetNotificationAlert()
                }
            } else {
                if self.isPoximityReportActive {
//                    self.removeReportNotificationAlert()
                }
                if self.isPoximityDeleveryNoteActive {
//                    self.removeDeliveryNoteNotificationAlert()
                }
            }
        }
    }
    @Published var isPoximityReportActive: Bool {
        willSet {
            objectWillChange.send()
            if newValue {
                if self.guardianActive {
//                    self.setReportNotificationAlert()
                }
            } else {
                if self.guardianActive {
//                    self.removeReportNotificationAlert()
                }
            }
        }
    }
    @Published var isPoximityDeleveryNoteActive: Bool {
        willSet {
            objectWillChange.send()
            if newValue {
                if self.guardianActive {
//                    self.setDeliveryNotetNotificationAlert()
                }
            } else {
                if self.guardianActive {
//                    self.removeDeliveryNoteNotificationAlert()
                }
            }
        }
    }
    
    @Published var errorTitle: String? {
        willSet { objectWillChange.send() }
    }
    @Published var errorMessage: String? {
        willSet { objectWillChange.send() }
    }
    @Published var completeTitle: String? {
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
        self.currentPage = .welcomePage
        self.officeArray = []
        self.reportArray = []
        self.userInfo = User(isEmpty: true)

        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

    }
    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
    }
    func getLocationStatusDesc() -> String {
        switch self.locationStatus {
            case .notDetermined: return NSLocalizedString("notDetermined", comment: "")
            case .authorizedWhenInUse: return NSLocalizedString("authorizedWhenInUse", comment: "")
            case .authorizedAlways: return NSLocalizedString("authorizedAlways", comment: "")
            case .restricted: return NSLocalizedString("restricted", comment: "")
            case .denied: return  NSLocalizedString("denied", comment: "")
            default: return  NSLocalizedString("default", comment: "")
        }
    }
    func getReportById(reportId: String) -> Report? {
        if let report = reportArray.first(where: {$0.reportId == reportId}) {
            return report
           // do something with foo
        } else {
           return nil
        }

    }
    func getCurrentRouteName() -> String {
        return officeArray[userInfo.officeIdx].routeArray[userInfo.routeIdx].name
    }
    func getCurrentOfficeName() -> String {
        return officeArray[userInfo.officeIdx].name
    }


    // FireBase
    func signInUser(userEmail: String, userPassword: String) -> String? {
        var signInErrorMessage = ""
        self.signInProcessing = true
//        self.firebaseAuth = Auth.auth()
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            
            guard error == nil else {
                self.signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                print(signInErrorMessage)
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                self.signInProcessing = false
            case .some(_):
                print("User signed in")

                self.signInProcessing = false

                let user = Auth.auth().currentUser
                if let user = user {
                    let uid = user.uid
                    let uemail = user.email
                    self.loadUserData(uid: uid, uemail: uemail!)
                }
            }
        }
        
        return signInErrorMessage
    }
    func loadUserData(uid: String, uemail: String) {
        print("trace result loadUserData")
        self.currentPage = .loadingPage
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        lazy var functions = Functions.functions()
        functions.httpsCallable("getGuardianInfo").call(["email": uemail]) { result, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            } else {
                if let data = result?.data as? NSDictionary {
                    self.loadResultData(result: data)
                }
            }
            withAnimation {
                self.currentPage = .homePage
            }
        }
    }
    func setRouteSelection(officeId:String, routeId: String) {
        print("set RouteId = \(routeId) officeId = \(officeId)")
        let decoder = JSONDecoder()
        self.currentPage = .loadingPage
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        lazy var functions = Functions.functions()
        let user = Auth.auth().currentUser
        if let user = user {
//            let uid = user.uid
            let uemail = user.email
            
            functions.httpsCallable("setMyGuardianInfo").call(["email": uemail, "officeId": officeId, "routeId": routeId]) { result, error in
                if let error = error as NSError? {
                    print(error.localizedDescription)
                } else {
                    if let data = result?.data as? NSDictionary {
                        
                        if let officeIdx = self.officeArray.firstIndex(where: {$0.officeId == officeId}) {
                            if let routeIdx = self.officeArray[officeIdx].routeArray.firstIndex(where: {$0.routeId == routeId}) {
                                self.userInfo.officeIdx = officeIdx
                                self.userInfo.routeIdx = routeIdx
                                self.userInfo.routeSelected = routeId
                                self.userInfo.officeSelected = officeId
                            }
                        }
                        self.loadResultData(result: data)
                    }
                }
                withAnimation {
                    self.currentPage = .homePage
                }
            }
        } else {
            print("erreur not login")
        }
    }
    func loadResultData(result: NSDictionary) {
//        print(result)
        print("trace loadResultData")
        if let u = result["userInfo"] as? NSDictionary {
            print("Trace loadResultData-userInfo")
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
            print("Trace loadResultData-officeInfo")
            self.officeArray = []
            for off in u {
                if let office = off as? NSDictionary {
                    if let officeId = office["officeId"] as? String {
                        if (officeId == self.userInfo.officeSelected) {
                            self.userInfo.officeIdx = self.officeArray.count
                        }
                        
                        var add = ""
                        var ona = ""
                        var ofGps = CLLocation(latitude: 46.820, longitude: -71.169)
                        if let address = office["address"] as? String {
                            add = address
                        }
                        if let oName = office["name"] as? String {
                            ona = oName
                        }
                        if let oGps = office["gps"] as? NSDictionary {
                            if let lat = oGps["_latitude"] {
                                if let lng = oGps["_longitude"] {
                                    if let latitude = CLLocationDegrees(String(describing: lat)) {
                                        if let longitude = CLLocationDegrees(String(describing: lng)) {
                                            ofGps = CLLocation(latitude: latitude, longitude: longitude)
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        let o = Office(officeId: officeId, name: ona, address: add, gps: ofGps, routeArray: [])
                        if let rArray = office["routeInfo"] as? NSArray {
                            for rou in rArray {
                                if let route = rou as? NSDictionary {
                                    if let routeId = route["id"] as? String {
//                                        if (routeId == self.userInfo.routeSelected) {
//                                            self.userInfo.routeIdx = self.officeArray.count
//                                        }
                                        if let rName = route["name"] as? String {
                                            if let rType = route["type"] as? Int {
                                                o.routeArray += [Route(routeId: routeId, officeId: officeId, name: rName, type: rType, active: true)]
                                            }
                                        }
                                        
                                        
                                    }
                                }
                                
                            }
                            o.routeArray.sort {
                                $0.name < $1.name
                            }
                            if let routeIdx = o.routeArray.firstIndex(where: {$0.routeId == self.userInfo.routeSelected}) {
                                self.userInfo.routeIdx = routeIdx
                            }
                        }
                        self.officeArray += [o]
                    }
                }
                
            }
            self.officeArray.sort {
                $0.name < $1.name
            }
//            self.loadOfficeArray(officeArray: offArray)
        }
        if let u = result["reportList"] as? NSArray {
            print("Trace loadResultData-reportList")
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
            if let location = lastLocation {
                self.reportArray.sort {
                    $0.gps.distance(from: location) < $1.gps.distance(from: location)
                }
            }
//            self.loadOfficeArray(officeArray: offArray)
        }
        
        self.objectWillChange.send()
        if self.guardianActive {
            verifPoximity()
//            if self.isPoximityReportActive {
//                self.setReportNotificationAlert()
//            }
//            if self.isPoximityDeleveryNoteActive {
//                self.setDeliveryNotetNotificationAlert()
//            }
        }
    }
    func createMemoOfficeNotification(rec: Recording) {
//        let memo = Memo(officeId: <#T##String#>, fileURL: <#T##URL#>)
    }
    func sendMemoTo(downloadURL: URL, to: String) {
        print("trace sendMemoTo")
        self.currentTaskStatus = .inProgress
        self.objectWillChange.send()
//        self.currentPage = .loadingPage
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        lazy var functions = Functions.functions()
        let params: [String: Any] = [
            "to": to,
            "url": "\(downloadURL)",
            "empId": self.userInfo.empId,
            "fName": self.userInfo.fName,
            "lName": self.userInfo.lName,
            "empType": self.userInfo.userType,
            "officeId": self.userInfo.officeSelected,
            "routeId": self.userInfo.routeSelected
        ]
        print(params)
        functions.httpsCallable("sendMemoTo").call(params) { result, error in
            if let error = error as NSError? {
                print("trace B")
                print(error.localizedDescription)
                self.currentTaskStatus = .error
                self.objectWillChange.send()
            } else {
                print("trace Success")
                self.currentTaskStatus = .success
                self.objectWillChange.send()
            }
        }
    }
    func saveMemoToFirestore(rec: Recording, to: String) {
        // Local file you want to upload
//        let localFile = URL(string: "path/to/image")!
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let memoRef = storageRef.child("memo/\(userInfo.userId)/\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "audio/m4a"

        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = memoRef.putFile(from: rec.fileURL, metadata: metadata)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
          // Upload resumed, also fires when the upload starts
            self.currentTaskStatus = .inProgress
            print("trace resume -> \(snapshot.description)")
        }

        uploadTask.observe(.pause) { snapshot in
          // Upload paused
            self.currentTaskStatus = .pause
        }

        uploadTask.observe(.progress) { snapshot in
          // Upload reported progress
            self.currentTaskProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }

        uploadTask.observe(.success) { snapshot in
            memoRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    self.sendMemoTo(downloadURL: downloadURL, to: to)
//                    self.currentTaskStatus = .success
                    return
                } else {
                    // Uh-oh, an error occurred!
                    self.currentTaskStatus = .error
                    return
                }
            }
            
            
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                print(error.localizedDescription)
                self.currentTaskStatus = .error
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                  // File doesn't exist
                  break
                case .unauthorized:
                  // User doesn't have permission to access file
                  break
                case .cancelled:
                  // User canceled the upload
                  break

                /* ... */

                case .unknown:
                  // Unknown error occurred, inspect the server response
                  break
                default:
                  // A separate error occurred. This is a good place to retry the upload.
                  break
                }
            }
        }
            
    }
    
    // Location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        if status == .authorizedAlways || status == .authorizedWhenInUse {
//        if status == .authorizedAlways {
            self.isLocationOk = true
        } else {
            self.isLocationOk = false
        }
        //        print(#function, statusString)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        lastLocation = location
        self.reportArray.sort {
            $0.gps.distance(from: location) < $1.gps.distance(from: location)
        }
        self.deliveryNoteArray.sort {
            $0.gps.distance(from: location) < $1.gps.distance(from: location)
        }
        objectWillChange.send()

        verifPoximity()
    }
    func addAlert(report: Report?, note: DeliveryNote?) {
        print("Trace -> addAlert")
        if let r = report {
            r.userAdvicedAt = Date().addingTimeInterval(28800)
//            alertReportArray += [r]
            sendReportProximityNotification(report: r, delay: 0)
        }
        if let n = note {
            n.userAdvicedAt = Date()
//            deliveryNoteArray += [n]
        }
    }
    func verifPoximity () {
        // valeur pour test
        //        Secure dist: 20.0 lat: 46.826 lng: -71.169
        //        Secure dist: 6.8 lat: 46.82512163489645 lng: -71.16894056998049
        //        Secure dist: 13.0 lat: 46.82816193830126 lng: -71.16197669042873
        //        Secure dist: 3.2 lat: 46.82620878600794 lng: -71.16670529914882
        //        Secure dist: 18.4 lat: 46.82690902216371 lng: -71.1694296386404
        //        Secure dist: 15.1 lat: 46.82685785514702 lng: -71.16165753519076
        //        Secure dist: 45.0 lat: 46.82824054444012 lng: -71.16184553366843
        
        // duree avec un rappel en seconde
        let dureeRappelNotification: Double = 60
        var cptNof: Double = 0
        // duree avant nouvelle notification en sec 60s X 60m X 8hrs = 28800 seconde
//        let dureeNextDayNotification: Double = 28800
        
        if guardianActive == true {
            if let location = lastLocation {
                //  Verifier Les report
                if self.isPoximityReportActive {
                    for i in 0 ..< reportArray.count {
                        let r = reportArray[i]
                        // place a remettre le userAdvicedAt a nil
                        if let advDate = r.userAdvicedAt {
//                            print("Trace now: \(Date())  userAdvicedAt prochain : \(advDate)")
                            if Date() > advDate {
                                r.userAdvicedAt = nil
                            }
                        }
                        if (r.proximityAlert == true && r.userAdvicedAt == nil) {
//                            if let gps = r.gps {
                                if let securedist = r.securedistance {
                                    if r.gps.distance(from: location) < securedist {
//                                        addAlert(report: r, note: nil)
                                        r.userAdvicedAt = Date().addingTimeInterval(dureeRappelNotification)
                                        sendReportProximityNotification(report: r, delay: cptNof * 5)
                                        cptNof += 1
                                    }
                                } else {
                                    //                            mettre une distance par default si pas de securdist
                                    if r.gps.distance(from: location) < 30 {
//                                        addAlert(report: r, note: nil)
                                        r.userAdvicedAt = Date().addingTimeInterval(dureeRappelNotification)
                                        sendReportProximityNotification(report: r, delay: cptNof * 5)
                                        cptNof += 1
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
//                        if let gps = nt.gps {
                            if nt.gps.distance(from: location) < 30 {
                                addAlert(report: nil, note: nt)
                            } else {
                                //                            print("Note id: \(nt.deliveryNoteId) dist: \(nt.gps.distance(from: location))")
                            }
//                        }
                    }
                }
//                print("verif Proximity FINISH")
            }
        }
    }
    func getCleanDistanceDislpay(loc1: CLLocation, loc2 :CLLocation) -> String {
        var dist = loc1.distance(from: loc2)

        if (dist > 1000) {
            dist = dist / 1000
            return "\(Double(round(10 * dist) / 10)) Km"
        } else {
            return "\(Double(round(10 * dist) / 10)) M"
        }
    }
    func getCleanDistanceDislpayMax100(loc1: CLLocation, loc2 :CLLocation) -> String {
        var dist = loc1.distance(from: loc2)
        if dist > 100000 {
            return "> 100 Km"
        } else if (dist > 1000) {
            dist = dist / 1000
            return "\(Double(round(10 * dist) / 10)) Km"
        } else {
            return "\(Double(round(10 * dist) / 10)) M"
        }
    }
    // NOTIFICATION
    func resetAlertNotificationStatus() -> Void {
        for report in self.reportArray {
            report.userAdvicedAt = nil
        }
        for deliveryNote in self.deliveryNoteArray {
            deliveryNote.userAdvicedAt = nil
        }
        return
    }
    func sendReportProximityNotification(report: Report, delay: Double) {
        print("trace sendReportProximityNotification")
        let content = UNMutableNotificationContent()
        var request: UNNotificationRequest
        content.title = report.getReportNotificationTitle()

        content.body = report.getReportNotificationSubTitle()

        content.sound = .defaultCritical
//                content.sound = UNNotificationSound.
        content.categoryIdentifier = "Proximity-Alert"
        content.userInfo = [
            "reportDictionaryFormat": report.getDictionaryFormat(),
            "notificationType" : "reportProximityAlert"
        ]

        let show = UNNotificationAction(identifier: "showReport", title: NSLocalizedString("show", comment: ""), options: .foreground)
//        let cancel = UNNotificationAction(identifier: "cancel", title: "Ne plus aviser aujourd'hui", options: .foreground)
        let category = UNNotificationCategory(identifier: "Proximity-Alert", actions: [show], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        if delay > 0 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
            request = UNNotificationRequest(identifier: "Proximity-Alert", content: content, trigger: trigger)
        } else {
            request = UNNotificationRequest(identifier: "Proximity-Alert", content: content, trigger: nil)
        }
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("notification envoyer delay = \(delay) reportid -> \(report.reportId)")
            }
        }
    }
    func getReportNotificationRequest(report: Report) -> UNLocationNotificationTrigger {
        // distance assigner par default
        var secureDistance: Double = 20

        let center = CLLocationCoordinate2D(latitude: report.gps.coordinate.latitude, longitude: report.gps.coordinate.longitude)
        if let securedistance = report.securedistance {
            secureDistance = securedistance
        }
        let region = CLCircularRegion(center: center, radius: secureDistance, identifier: report.reportId)
        print("Secure dist: \(secureDistance) lat: \(report.gps.coordinate.latitude) lng: \(report.gps.coordinate.longitude)")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        return UNLocationNotificationTrigger(region: region, repeats: true)

    }
    func removeReportNotificationAlert () {
        print("trace removeReportNotificationAlert")
        if self.reportArray.count > 0 {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: self.reportArray.map { $0.reportId })
        }
    }
    func removeDeliveryNoteNotificationAlert() {
        print("trace removeDeliveryNoteNotificationAlert")
        if self.deliveryNoteArray.count > 0 {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: self.deliveryNoteArray.map { $0.deliveryNoteId })
        }
    }
    func setReportNotificationAlert() {
        print("trace setReportNotificationAlert")
        for report in reportArray {
            self.addReportNotificationAlert(report: report)
        }
    }
    func setDeliveryNotetNotificationAlert() {
        print("trace setDeliveryNotetNotificationAlert")
//        for deliveryNote in deliveryNoteArray {
//            self.addDeliveryNoteNotificationAlert(report: report)
//        }
    }
    func addReportNotificationAlert(report: Report) {
        print("trace addReportNotificationAlert")
        let content = UNMutableNotificationContent()
        content.title = "Alerte de proximité"

        content.body = report.getReportTypeTitle()

        content.sound = .defaultCritical
//                content.sound = UNNotificationSound.
        content.categoryIdentifier = "Proximity-Alert"
        content.userInfo = [
            "reportDictionaryFormat": report.getDictionaryFormat(),
            "notificationType" : "reportProximityAlert"
        ]
        let category = UNNotificationCategory(identifier: "reportProximityAlert", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let trigger = self.getReportNotificationRequest(report: report)
        let request = UNNotificationRequest(identifier: "reportProximityAlert", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("notification envoyer")
            }
        }
    }
    func addDeliveryNoteNotificationAlert(report: Report) {
        print("trace addDeliveryNoteNotificationAlert")
        let content = UNMutableNotificationContent()
        content.title = report.getReportNotificationTitle()

        content.body = report.getReportNotificationSubTitle()

        content.sound = .defaultCritical
//                content.sound = UNNotificationSound.
        content.categoryIdentifier = "Proximity-Alert"
        content.userInfo = [
            "reportDictionaryFormat": report.getDictionaryFormat(),
            "notificationType" : "reportProximityAlert"
        ]
        let category = UNNotificationCategory(identifier: "reportProximityAlert", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let trigger = self.getReportNotificationRequest(report: report)
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


