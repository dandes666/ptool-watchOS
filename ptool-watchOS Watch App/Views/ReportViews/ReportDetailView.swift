//
//  ReportDetailView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI
import UserNotifications
struct ReportDetailView: View {
    var report: Report
    var body: some View {
        VStack {
            if let type = report.type {
                switch type {
                case "dog":
                    Image("Dog")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        
                default:
                    Image("Alert")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                }
            } else {
                Text("no type")
            }
            Button("Schedule Notification")
            {
                let content = UNMutableNotificationContent()
                content.title = "Alerte de proximité"

                content.body = report.getReportTypeTitle()

                content.sound = .defaultCritical
//                content.sound = UNNotificationSound.
                content.categoryIdentifier = "reportProximityAlert"
                content.userInfo = [
                    "notifData": [
                        "reportId": report.reportId,
                        "name": report.getName(),
                        "desc": report.getDesc(),
                        "type": report.getType(),
                        "status": report.getStatus()
                    ],
                    "notificationType" : "reportProximityAlert"
                ]
                let category = UNNotificationCategory(identifier: "reportProximityAlert", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category])
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "milk", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        print("notification envoyer")
                    }
                }
            }
        }
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: Report(reportId: "2342342"))
    }
}
