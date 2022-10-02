//
//  ReportDetailView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

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
        }
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: Report(reportId: "2342342"))
    }
}
