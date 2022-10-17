//
//  NotificationView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var db: AppManager
    var notifTitle: String?
    var notifMessage: String?
    var notificationType: String?
    var report: Report?
    var body: some View {
        VStack {
            if let type = notificationType {
                if type == "reportProximityAlert" {
                    if let r = report {
                        ReportDetailView(report: r)
                    } else {
                        Text("trace 3")
                    }
                } else {
                    Text("trace 2")
                }
            } else {
                Text("trace 1")
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(notificationType: "reportProximityAlert", report: Report(reportId: "REPORTID!12345"))
    }
}
