//
//  DeliveryNoteItemView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-18.
//

import SwiftUI

struct DeliveryNoteItemView: View {
    let dn: DeliveryNote
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DeliveryNoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryNoteItemView(dn: DeliveryNote(adviceId: "123123", desc: "description de la note de livraison", gps: CLLocation(latitude: 46.826, longitude: -71.169), pocList: []))
    }
}
