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
            if let type = report.type {
                HStack {
                    switch type {

                    case "dog":
                        Image("Dog")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .leading)
                    case "brokenstep":
                        Image("BrokenStep")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .leading)
                    case "ice":
                        Image("Ice")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .leading)
                    default:
                        Image("Alert")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                    
                    VStack(alignment: .center) {
                        Text(report.getReportTypeTitle())
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(3)
                            .foregroundColor(Color.red)
                    }
                }
//                .padding(2)
            }
//            if let nMessage = message {
//                Text(nMessage)
//                    .font(.headline)
//                    .lineLimit(nil)
////                    .padding(1)
//                    .foregroundColor(Color.red)
//
//            }
        }
    }
}

struct NotificationReportTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationReportTitleView(title: "Alerte de Proximite", message: "Danger de Chien", report: Report(reportId: "IdREport", name: nil, desc: "Chien extérieur occasionnel", type: "ice", status: 1, gps: nil, proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil))
    }
}
