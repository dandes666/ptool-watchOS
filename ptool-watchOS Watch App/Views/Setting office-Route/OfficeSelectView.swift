//
//  OfficeSelectView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct OfficeSelectView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
        ScrollView {
            ForEach(db.officeArray) { off in
                NavigationLink(value: off) {
                    HStack {
                        Image(getOfficeImageName(office: off))
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .trailing)
                        Spacer()
                        VStack {
                            Text(off.name)
                            Text("\(off.routeArray.count) \(NSLocalizedString("routes", comment: ""))")
                        }
                        Spacer()
                        Image("next")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .leading)
                    }
                }
            }
        }
        .navigationTitle(NSLocalizedString("config", comment: ""))
        .navigationDestination(for: Office.self) { off in
            RouteSelectView(routeArray: off.routeArray)
        }
    }
    func getOfficeImageName(office: Office) -> String {
        if office.officeId == db.userInfo.officeSelected {
            return "checked-on"
        } else {
            return "checked-off"
        }
    }
}

struct OfficeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        OfficeSelectView().environmentObject(AppManager())
    }
}
