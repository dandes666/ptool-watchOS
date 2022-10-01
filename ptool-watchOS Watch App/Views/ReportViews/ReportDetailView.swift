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
        Text("detail")
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: Report(reportId: "2342342"))
    }
}
