//
//  NotificationReportBannerView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import SwiftUI

struct NotificationReportBannerView: View {
    var title: String?
    var message: String?
    var report: Report
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                NotificationReportTitleView(title: title,  message: message, report: report)
            }
        }
    }
}

struct NotificationReportBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationReportBannerView(title: "Alert de Proximite", message: "Danger de Chien", report: Report(reportId: "IdREport", name: nil, desc: "Chien extérieur occasionnel", type: "dog", status: 1, gps: nil, proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil))
    }
}
