//
//  RouteSelectConfirmView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-08.
//

import SwiftUI

struct RouteSelectConfirmView: View {
    @EnvironmentObject var db: AppManager
    @EnvironmentObject var router: Router
    var route: Route
    var body: some View {
        VStack {
            Text(NSLocalizedString("Voulez-vous charger les information de la route", comment: ""))
            Text(route.name)
            Button(NSLocalizedString("je confirme", comment: ""))
            {
                db.setRouteSelection(officeId: route.officeId, routeId: route.routeId)
                router.reset()
            }.padding(.top, 15)
        }
    }
}

struct RouteSelectConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSelectConfirmView(route: Route(routeId: "Routeid01", officeId: "officeid-test", name: "LC00001", type: 1, active: true))
    }
}
