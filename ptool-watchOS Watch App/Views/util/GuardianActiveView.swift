//
//  GuardianActiveView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct GuardianActiveView: View {
    @EnvironmentObject var db: AppManager
    @State private var fruits = [
        "Apple",
        "Banana",
        "Papaya",
        "Mango"
    ]
    var body: some View {
        ScrollView {
            //        Text("Verification de proximite")
            VStack{
                if db.lastLocation == nil || !db.isLocationOk {

                    Text("\(NSLocalizedString("Attention", comment: "")): ")
                        .foregroundColor(Color.red)
                        .font(Font.title2)
                        
                    Text(db.getLocationStatusDesc())
                        .foregroundColor(Color.red)
                        .font(Font.caption)
                        .lineLimit(nil)
                        .padding(.bottom, 10)
                    Button("\(NSLocalizedString("Corriger", comment: ""))...") {
                        db.requestLocation()
                    }
                        .foregroundColor(Color.red)
                        .padding(.bottom, 20)

                }
                Spacer()
                Toggle(isOn: $db.guardianActive) {
                    Text(NSLocalizedString("Alert de Proximite", comment: ""))
                        .lineLimit(2)
                }.padding(2)
                if db.guardianActive {
                    Toggle(NSLocalizedString("Signalement", comment: ""), isOn: $db.isPoximityReportActive)
                        .padding()
                    Toggle(NSLocalizedString("Notes", comment: ""), isOn: $db.isPoximityDeleveryNoteActive)
                        .padding()
                }
                Spacer()
                Button(NSLocalizedString("Reiniatiliser les alertes", comment: "")) {
                    db.resetAlertNotificationStatus()
                }
                //        PtoolLogoView(imageWidth: 40, imageHeight: 40)
            }
        }
    }
}

struct GuardianActiveView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AppManager()
        GuardianActiveView().environmentObject(db)
    }
}
