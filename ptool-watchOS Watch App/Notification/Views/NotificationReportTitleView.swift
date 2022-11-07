//
//  NotificationReportTitleView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import SwiftUI

struct NotificationReportTitleView: View {
    var title: String?
    var message: String?
    var report: Report
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: report.getReportImageName())
                    .resizable()
                    .foregroundColor(report.getReportImageColor())
                    .frame(width: 40, height: 40, alignment: .leading)
                
                VStack(alignment: .center) {
                    Text(report.getReportTypeTitle())
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(3)
                        .foregroundColor(Color.red)
                }
            }

        }
    }
}

struct NotificationReportTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationReportTitleView(title: "Alerte de Proximite", message: "Danger de Chien", report: Report(reportId: "IdREport", name: nil, desc: "Chien extérieur occasionnel", type: "ice", status: 1, gps: CLLocation(latitude: 46.826, longitude: -71.169), proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil))
    }
}
