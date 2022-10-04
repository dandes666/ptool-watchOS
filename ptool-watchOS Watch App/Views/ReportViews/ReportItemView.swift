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
        Text(report.getReportTypeTitle())
    }
}

struct ReportItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReportItemView(report: Report(reportId: "234234234234"))
    }
}
