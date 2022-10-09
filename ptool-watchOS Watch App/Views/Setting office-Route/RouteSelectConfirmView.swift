//
//  RouteSelectConfirmView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-08.
//

import SwiftUI

struct RouteSelectConfirmView: View {
    @EnvironmentObject var db: AppManager
    var route: Route
    var body: some View {
        VStack {
            Text("Voulez-vous charger les information de la route")
            Text(route.name)
            Button("Confirm")
            {
                db.setRouteSelection(officeId: route.officeId, routeId: route.routeId)
            }
        }
    }
}

struct RouteSelectConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSelectConfirmView(route: Route(routeId: "Routeid01", officeId: "officeid-test", name: "LC00001", type: 1, active: true))
    }
}
