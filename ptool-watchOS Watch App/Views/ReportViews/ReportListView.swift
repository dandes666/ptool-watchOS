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
        let rArray = db.getProximityRepportArray()
        ScrollView {
            if rArray.count > 0 {
                ForEach(rArray) { r in
                    NavigationLink(value: r) {
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
        .navigationDestination(for: Report.self) { r in
            ReportDetailView(report: r)
        }
        .navigationBarTitle(NSLocalizedString("nt-home", comment: ""))
    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AppManager()
        ReportListView().environmentObject(db)
    }
}
