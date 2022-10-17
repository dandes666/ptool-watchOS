//
//  GuardianActiveView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct GuardianActiveView: View {
    @EnvironmentObject var db: AppManager
//        .onChange(of:)
    var body: some View {
//        Text("Verification de proximite")
        Spacer()
        Toggle(isOn: $db.guardianActive) {
            Text("Alerte de proximité")
                .lineLimit(2)
        }.padding(2)
        if db.guardianActive {
            Toggle("Signalements", isOn: $db.isPoximityReportActive)
                .padding()
            Toggle("Notes", isOn: $db.isPoximityDeleveryNoteActive)
                .padding()
        }
        Spacer()
        Button("Reiniatiliser les alertes") {
            db.resetAlertNotificationStatus()
        }
//        PtoolLogoView(imageWidth: 40, imageHeight: 40)
    }
}

struct GuardianActiveView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianActiveView()
    }
}
