//
//  ptool_watchOSApp.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-13.
//

import SwiftUI
import Firebase
import UserNotifications
@main
struct ptool_watchOS_Watch_AppApp: App {

//    @StateObject var router = Router()
    
    private var delegate: NotificationDelegate = NotificationDelegate()

    init() {
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        center.requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
            if success{
                print("All set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
            // Provisional authorization granted.
        FirebaseApp.configure()
      }
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(delegate.db)
                .environmentObject(delegate.router)
        }
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "Proximity-Alert")
        #endif
    }
}
