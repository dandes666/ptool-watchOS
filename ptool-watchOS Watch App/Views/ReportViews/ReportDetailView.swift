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
        
        ScrollView {
            VStack {
                if let type = report.type {
                    HStack {
                        switch type {
                        case "dog":
                            Image("Dog")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                            
                        default:
                            Image("Alert")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                        Text(report.getReportTypeTitle())
                            .foregroundColor(Color.red)
                            .lineLimit(2)
                            .font(.system(size: 17, weight: .bold))
                    }
                }
                ForEach(report.pocList, id: \.self) { poc in
                    Text(poc.getAddress())
                        .font(.system(size: 13, weight: .medium))
                        .lineLimit(1)
                        .foregroundColor(Color.cyan)
                }
                if let desc = report.desc {
                    Text(desc)
                        .lineLimit(nil)
                        .font(.system(size: 14, weight: .medium))
                        .padding()
                }
                ForEach(report.imageList, id: \.self) { ri in
                    AsyncImage(url: URL(string: ri.url)) { image in
                        image.resizable()
                    } placeholder: {
                        LoadingView()
                        Color.red
                    }
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Button("test")
                {
                    //                db.sendReportProximityNotification(report: report)
                    print(report.getDictionaryFormat())
                }
            }
        }
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: Report(reportId: "id12345", name: nil, desc: "Description du Signalement", type: "dog", status: 1, gps: CLLocation(latitude: 46.826, longitude: -71.169), proximityAlert: false, imageList: [
                ReportImage(url: "https://firebasestorage.googleapis.com/v0/b/postmantools.appspot.com/o/c3rHI71qQcrPRGnAT4uF%2Fimage%2Fmessage%2Fn7Z61DqH4pMxP0p0Jm3WzHXBVW72%2Ffd5d289e-0d67-4c9b-bcf0-68364471c90c.jpg?alt=media&token=fccd5ff7-c0d8-4e7e-b5a3-818f39ffa82c", fullPath: "", isPrimary: true)
            ], note: [], pocList: [
            ReportPocInfo(pocId: "1", address: "123 de la martine"),
            ReportPocInfo(pocId: "1", address: "777 monseigneur bourget benb ben long"),
            ReportPocInfo(pocId: "1", address: "123 de la martine"),
            ReportPocInfo(pocId: "1", address: "123 de la martine")
        ], securedistance: 20))
    }
}
