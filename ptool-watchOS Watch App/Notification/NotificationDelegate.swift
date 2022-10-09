//
//  NotificationDelegate.swift
//  ptool-watchOS
//
//  Created by Dave Thibeault on 2022-10-09.
//

import Foundation
import UserNotifications
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    var db = AppManager()
//    var db: AppManager
//    init(db: AppManager) {
//        self.db = db
//        super.init()
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("trace receive delegate")
        print(db.userInfo.lName)
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("trace will present")
        print(db.userInfo.lName)
        completionHandler([.badge, .sound, .banner])
    }

}
