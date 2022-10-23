//
//  ConfigView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var db: AppManager
    @Binding var isGuardianActive: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                Text(NSLocalizedString("Bureau", comment: ""))
                    .padding(EdgeInsets.init(top: 2, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: OfficeSelectView()) {
                    VStack() {
                        Text("\(db.officeArray[db.userInfo.officeIdx].name)")
                        Text("\(db.officeArray[db.userInfo.officeIdx].address)")
                            .font(.system(size: 11))
                    }
                }
//                Spacer()
                Text(NSLocalizedString("Route", comment: ""))
                    .padding(EdgeInsets.init(top: 15, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: RouteSelectView(routeArray: db.officeArray[db.userInfo.officeIdx].routeArray)) {
                    VStack() {
                        Text("\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                    }
                }
//                Spacer()
                Text(NSLocalizedString("Utilisateur", comment: ""))
                    .padding(EdgeInsets.init(top: 15, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: UserEditIView(user: db.userInfo)) {
                    VStack() {
                        Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                        Text("\(db.userInfo.empId)")
                            .font(.system(size: 16))
                    }
                }
//                Spacer()
                Text(NSLocalizedString("Application", comment: ""))
                    .padding(EdgeInsets.init(top: 15, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: GuardianActiveView()) {
                    VStack {
                        Text(NSLocalizedString("Alert de Proximite", comment: ""))
                            .font(.system(size: 16))
                        HStack {
                            if db.isPoximityReportActive == true {
                                Text(NSLocalizedString("Signalement", comment: ""))
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 12))
                            }
                            if db.isPoximityDeleveryNoteActive {
                                Text(NSLocalizedString("Notes", comment: ""))
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }
//                .padding(2)
//                .buttonStyle(.bordered)
                
//                .padding()
//                Spacer()
            }
//            NavigationLink
//            .navigationTitle("Config")
        }.navigationTitle(NSLocalizedString("Annuler", comment: ""))
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(isGuardianActive: .constant(true))
    }
}
