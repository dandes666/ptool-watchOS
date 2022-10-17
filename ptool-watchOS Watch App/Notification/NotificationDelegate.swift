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
//        print(db.userInfo.lName)
       
//        let userInfo = response.notification.request.content.userInfo
        let notificationData =
        response.notification.request.content.userInfo as? [String: Any]
//        if let rep = response as? NSDictionary {
            if response.notification.request.content.categoryIdentifier == "Proximity-Alert" {
                print("trace receive delegate Proximity-Alert")
                if let notificationType = notificationData?["notificationType"] as? String {
                    switch notificationType {
                    case "reportProximityAlert":
                        if let reportData = notificationData?["reportDictionaryFormat"] as? NSDictionary {
                            let reportId = reportData["reportId"] as! String
                            print("reportId = \(reportId)")
                            switch response.actionIdentifier {
                            case "show":
                                //             sharedMeetingManager.acceptMeeting(user: userID, meetingID: meetingID)
                                print("action -> show")
                                break
                                
                            case "cancel":
                                //             sharedMeetingManager.declineMeeting(user: userID, meetingID: meetingID)
                                print("action -> cancel")
                                break
                                
                            case UNNotificationDefaultActionIdentifier,
                            UNNotificationDismissActionIdentifier:
                                // Queue meeting-related notifications for later
                                //  if the user does not act.
                                //             sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
                                print("trace1 actionIdentifier: \(response.actionIdentifier)")
                                break
                                
                            default:
                                print("trace2 actionIdentifier: \(response.actionIdentifier)")
                                break
                            }
                        }
                    default:
                        print("Erreur mauvais type = \(notificationType)")
                    }
                }
            }
            else {
                // Handle other notification types...
            }
//        }
            
       // Always call the completion handler when done.
       completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("trace will present")
//        r.userAdvicedAt = Date().addingTimeInterval(dureeRappelNotification)
//        print(db.userInfo.lName)
        completionHandler([.badge, .sound, .banner])
    }

}
