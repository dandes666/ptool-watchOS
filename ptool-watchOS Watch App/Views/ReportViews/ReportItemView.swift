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
        Text(getTitle(report: report))
    }
    func getTitle(report: Report) -> String {
        return report.reportId
//        if let name = report.name {
//            return name
//        } else if let desc = report.desc {
//            return desc
//        } else if let type = report.type {
//            return type
//        } else {
//            return report.reportId
//        }
//        if let name = report.name {
//            return name? ""
//        } else if let desc = report.desc {
//            return desc
//        } else if let type = report.type {
//            return type
//        } else {
//            return report.reportId
//        }
    }
}

struct ReportItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReportItemView(report: Report(reportId: "234234234234"))
    }
}
