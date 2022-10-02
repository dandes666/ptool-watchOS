//
//  LocationManager.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
import CoreLocation
import Combine
import UserNotifications

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
            if success{
                print("All set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
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

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
//        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        verifLocation(location: location)
//        print(#function, location)
    }
    func verifLocation(location: CLLocation) {
//        let content = UNMutableNotificationContent()
//        content.title = "Drink some milk!"
//        content.subtitle = "you have 10 sec"
//        content.sound = .default
//        content.categoryIdentifier = "myCategory"
//        let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//        let request = UNNotificationRequest(identifier: "milk", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request) { (error) in
//            if let error = error{
//                print(error.localizedDescription)
//            }else{
//                print("scheduled successfully")
//                ReportDetailView(report: Report(reportId: "testtetetet"))
//            }
//        }
    }
}
