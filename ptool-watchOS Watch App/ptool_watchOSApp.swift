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
    
    @StateObject var viewRouter = ViewRouter()
    @StateObject private var appManager = AppManager()
//    @StateObject var am2 = AppManager()
//    @StateObject private var dataController = DataController()
//    let var ref: DatabaseReference!
    
    private var delegate: NotificationDelegate = NotificationDelegate()
//        .environmentObject(appManager)
//    private var delegate: NotificationDelegate
//    delegate = NotificationDelegate()
//        .environmentObject(appManager)
    init() {
//        self.delegate = NotificationDelegate(db: self.appManager)
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
//        ref = Database.database().reference()
      }
    var body: some Scene {
        WindowGroup {
//            NotificationDelegate().environmentObject(appManager)
            MotherView().environmentObject(viewRouter)
//                .environmentObject(appManager)
                .environmentObject(delegate.db)
//            ContentView()
        }
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "reportProximityAlert")
        #endif
    }
}
