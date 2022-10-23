//
//  ReportListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct ReportListView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
//        var r: Report
//        var reportArray: [Report] = db.reportArray
        NavigationView() {
            ScrollView {
                if db.reportArray.count > 0 {
                    ForEach(db.reportArray) { r in
                        NavigationLink(destination: ReportDetailView(report: r)) {
                            VStack {
                                ReportItemView(report: r)
                                if let location = db.lastLocation {
                                    Text(db.getCleanDistanceDislpay(loc1: r.gps, loc2: location))
                                }
                            }
                        }
                    }
                } else {
                    HStack {
                        Text("\(NSLocalizedString("Aucun signalement pour cette route", comment: "")) (")
                            .fontWeight(Font.Weight.bold)
                            .foregroundColor(Color.red)
                        + Text(db.getCurrentRouteName())
                            .fontWeight(Font.Weight.black)
                        + Text(")")
                            .fontWeight(Font.Weight.bold)
                            .foregroundColor(Color.red)
                    }
                        .lineLimit(5)
                }
            }
        }.navigationTitle("Retour")
    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AppManager()
        ReportListView().environmentObject(db)
    }
}
