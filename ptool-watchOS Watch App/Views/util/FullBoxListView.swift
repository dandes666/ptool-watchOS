//
//  FullBoxListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct FullBoxListView: View {
    @EnvironmentObject var db: AppManager
    var fullBoxArray: [Report] {
        return db.getFullBoxArray()
    }
    var pocArray: [ReportPocInfo] {
        var pocArray: [ReportPocInfo] = []
        for f in fullBoxArray {
            pocArray += f.pocList
        }
        return pocArray.sorted {
            $0.seqPosTot < $1.seqPosTot
        }
    }
    var body: some View {
        ScrollView {
            VStack {
                if pocArray.count > 0 {
                    Text("Boite Pleine")
                    ForEach(pocArray) { poc in
                        Text(poc.address)
                            .foregroundColor(poc.color)
                    }
                } else {
                    HStack {
                        Text("\(NSLocalizedString("Aucune boite plienne pour cette route", comment: "")) (")
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
        }
    }
    
}

struct FullBoxListView_Previews: PreviewProvider {
    static var previews: some View {
        FullBoxListView()
            .environmentObject(AppManager())
    }
}
