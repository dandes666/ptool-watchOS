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
    var type: String?
    var report: Report?
    
    override var body: NotificationView {
        NotificationView(notifTitle: title, notifMessage: message, notificationType: type, report: report)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didReceive(_ notification: UNNotification) {
//        let modelData = ModelData()

        let notificationData =
            notification.request.content.userInfo as? [String: Any]

        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]
//        reportIdx = alert?["reportIdx"] as? Int
        type = alert?["notificationType"] as? String
        title = alert?["title"] as? String
        message = alert?["body"] as? String

        if let reportData = notificationData?["reportData"] as? NSDictionary {
            if let reportId = reportData["reportId"] as? String {
                if let name = reportData["name"] as? String {
                    if let desc = reportData["desc"] as? String {
                        if let type = reportData["type"] as? String {
                            if let status = reportData["status"] as? Int {
                                report = Report(reportId: reportId, name: name, desc: desc, type: type, status: status, gps: nil, proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil)
//                                report = Report(reportId: reportId, name: name, desc: desc, type: type, status: status)
                            }
                        }
                    }
                }
            }
        }
    }
}
