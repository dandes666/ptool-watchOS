//
//  DeliveryNoteListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct DeliveryNoteListView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
        NavigationView() {
            ScrollView {
                if db.deliveryNoteArray.count > 0 {
                    ForEach(db.deliveryNoteArray) { d in
                        NavigationLink(destination: DeliveryNoteDetailView(dn: d)) {
                            VStack {
                                DeliveryNoteItemView(dn: d)
                                if let location = db.lastLocation {
                                    Text(db.getCleanDistanceDislpay(loc1: d.gps, loc2: location))
                                }
                            }
                        }
                    }
                } else {
                    HStack {
                        Text("\(NSLocalizedString("Aucune note de livraison pour cette route", comment: "")) (")
                            .fontWeight(Font.Weight.bold)
                            .foregroundColor(Color.red)
                        + Text(db.getCurrentRouteName())
                            .fontWeight(Font.Weight.black)
                        + Text(")")
                            .fontWeight(Font.Weight.bold)
                            .foregroundColor(Color.red)
                    }
                        .lineLimit(5)
                        .padding(.top, 20)
                }
            }
        }.navigationTitle(NSLocalizedString("Retour", comment: ""))
    }
}

struct DeliveryNoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AppManager()
        DeliveryNoteListView().environmentObject(db)
    }
}
