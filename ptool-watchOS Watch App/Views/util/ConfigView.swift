//
//  ConfigView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var db: DataController
    var body: some View {
        NavigationView {
            ScrollView {
                GuardianActiveView()
                    .padding(20)
                Text("Utilisateur")

                NavigationLink(destination: UserEditIView(user: db.userInfo)) {
                    VStack() {
                        Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                        Text("\(db.userInfo.empId)")
                            .font(.system(size: 16))
                    }
                }
                .buttonStyle(.bordered)
//                .padding()
                Spacer()
                Text("Bureau")
                NavigationLink(destination: OfficeSelectView()) {
                    VStack() {
                        Text("\(db.officeArray[db.userInfo.officeIdx].name)")
                        Text("\(db.officeArray[db.userInfo.officeIdx].address)")
                            .font(.system(size: 11))
                    }
                }
                Spacer()
                Text("Route")
                NavigationLink(destination: RouteSelectView()) {
                    VStack() {
                        Text("\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                    }
                }
            }
//            NavigationLink
//            .navigationTitle("Config")
        }.navigationTitle("Config")
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
