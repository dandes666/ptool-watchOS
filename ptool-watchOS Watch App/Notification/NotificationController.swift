//
//  NotificationController.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
//    var landmark: Landmark?
    var title: String?
    var message: String?
    var nType: String?
    var report: Report?
    
    override var body: NotificationView {
        NotificationView(notifTitle: title, notifMessage: message, notificationType: nType, report: report)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
//        print("trace notification controller visible")
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
//        print("trace notification controller invisible")
        super.didDeactivate()
    }
    
    override func didReceive(_ notification: UNNotification) {
//        print("trace NotificationController didReceive")
//        notificationActions = [UINotificationAction(identifier: "ok", title:"Ok",options:[])]
        let notificationData =
            notification.request.content.userInfo as? [String: Any]
        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]

        title = alert?["title"] as? String
        message = alert?["body"] as? String
        if let notificationType = notificationData?["notificationType"] as? String {
            self.nType = notificationType
            
            
            switch notificationType {
            case "reportProximityAlert":
                if let r = notificationData?["reportDictionaryFormat"] as? NSDictionary{
                    report = Report(dictionaryFormat: r)
                }
            default:
                print("Erreur notificationType -> \(notificationType)")
                
                //            }
            }
        }
    }
}
