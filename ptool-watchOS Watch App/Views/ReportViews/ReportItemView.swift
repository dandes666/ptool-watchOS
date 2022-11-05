//
//  ReportItemView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct ReportItemView: View {
    var report: Report
    var body: some View {
        HStack {
            Image(report.getReportImageName())
            VStack {
                Text(report.getReportTypeTitle())
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color.red)
                ForEach(report.pocList, id: \.self) { poc in
                    //            for p in report.pocList {
                    if let add = poc.address {
                        Text(add)
                            .font(.system(size: 10, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(poc.color)
                    }
                }
                
            }
        }
    }
}

struct ReportItemView_Previews: PreviewProvider {

    static var previews: some View {
        ReportItemView(report: Report(reportId: "id12345", name: nil, desc: "Description du Signalement", type: "dog", status: 1, gps: CLLocation(latitude: 46.826, longitude: -71.169), proximityAlert: false, imageList: [], note: [], pocList: [
//                ReportPocInfo(pocId: "1", address: "123 de la martine"),
//                ReportPocInfo(pocId: "1", address: "777 monseigneur bourget benb ben long"),
//                ReportPocInfo(pocId: "1", address: "123 de la martine"),
//                ReportPocInfo(pocId: "1", address: "123 de la martine")
            ], securedistance: 20))
    }
}
