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
    var router = Router()
    
//    var db: AppManager
//    init(db: AppManager) {
//        self.db = db
//        super.init()
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("trace NotificationDelegate didReceive")

        let notificationData = response.notification.request.content.userInfo as? [String: Any]
        if response.notification.request.content.categoryIdentifier == "Proximity-Alert" {
//            print("trace receive delegate Proximity-Alert")
            if let notificationType = notificationData?["notificationType"] as? String {
                switch notificationType {
                    
                //  MARK: receive-type reportProximityAlert
                    
                case "reportProximityAlert":
                    if let reportData = notificationData?["reportDictionaryFormat"] as? NSDictionary {
                        let reportId = reportData["reportId"] as! String
//                        print("reportId = \(reportId)")
//                        print("trace actionIdentifier: \(response.actionIdentifier)")
                        switch response.actionIdentifier {
                        case "showReport":
//                            print("action -> show")
                            if let report = db.getReportById(reportId: reportId) {
                                router.reset()
                                router.path.append(MasterRoute.reportList)
                                router.path.append(report)
                            }
                            break
                        case UNNotificationDismissActionIdentifier:
//                            print("action -> dismiss")
                            break
                        case UNNotificationDefaultActionIdentifier,
                        UNNotificationDismissActionIdentifier:
                            // Queue meeting-related notifications for later
                            //  if the user does not act.
                            //             sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
//                            print("trace1 actionIdentifier: \(response.actionIdentifier)")
                            break
                            
                        default:
//                            print("trace2 actionIdentifier: \(response.actionIdentifier)")
                            break
                        }
                    }
                
                //  MARK: receive-type officeProximityAlert
                   
                case "officeProximityAlert":
                    print("officeProximityAlert")
                    if let officeId = notificationData?["officeId"] as? String {
                        switch response.actionIdentifier {
                        case "showMemo":
                            db.officeActiveMemoListId = officeId
                            router.reset()
                            router.path.append(MasterRoute.officeActiveMemoList)
                            break
                        case "notifRemindLater":
                            break
                        case "notifRemindnotToday":
                            break
                        case UNNotificationDismissActionIdentifier:
//                            print("action -> dismiss")
                            break
                        case UNNotificationDefaultActionIdentifier,
                        UNNotificationDismissActionIdentifier:
                            // Queue meeting-related notifications for later
                            //  if the user does not act.
                            //             sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
//                            print("trace1 actionIdentifier: \(response.actionIdentifier)")
                            break
                            
                        default:
//                            print("trace2 actionIdentifier: \(response.actionIdentifier)")
                            break
                        }
                    }
                    
                default:
                    print("Erreur mauvais type = \(notificationType)")
                }
            }
        }
        else {
            print("trace 2")
            // Handle other notification types...
        }

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
