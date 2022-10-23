//
//  DeliveryNoteDetailView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct DeliveryNoteDetailView: View {
    var dn : DeliveryNote
    var body: some View {
        Text("DeliveryNoteDetailView")
    }
}

struct DeliveryNoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryNoteDetailView(dn: DeliveryNote(adviceId: "123123", desc: "description de la note de livraison", gps: CLLocation(latitude: 46.826, longitude: -71.169), pocList: []))
    }
}
