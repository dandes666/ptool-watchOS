//
//  NotificationReportView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import SwiftUI

struct NotificationReportView: View {
    var title: String?
    var message: String?
    var report: Report
    var body: some View {
        ZStack {
//            Color.black
//                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    
                    
                    NotificationReportBannerView(title: title, message: message, report: report)
                    if let desc = report.desc {
                        Text(desc)
                            .lineLimit(nil)
                            .padding(13)
                    }
                }
                
            }
        }
    }
}

struct NotificationReportView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationReportView(title: "Alert de Proximite", message: "Danger de Chien", report: Report(reportId: "IdREport", name: nil, desc: "Chien extérieur occasionnel", type: "dog", status: 1, gps: CLLocation(latitude: 46.826, longitude: -71.169), proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil))
    }
}
