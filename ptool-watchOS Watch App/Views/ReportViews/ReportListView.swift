//
//  ReportListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct ReportListView: View {
    @EnvironmentObject var db: DataController
    var body: some View {
//        var r: Report
//        var reportArray: [Report] = db.reportArray
        NavigationView() {
            ScrollView {
                ForEach(db.reportArray) { r in
                    NavigationLink(destination: ReportDetailView(report: r)) {
                        ReportItemView(report: r)
                    }
                }
            }
        }
    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListView()
    }
}
