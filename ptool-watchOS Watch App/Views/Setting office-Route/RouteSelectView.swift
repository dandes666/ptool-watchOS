//
//  RouteSelectView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct RouteSelectView: View {
    @EnvironmentObject var db: AppManager
    var routeArray: [Route]
    var body: some View {
        ScrollView {
            ForEach(routeArray) { route in
                
                NavigationLink(value: route) {
                    VStack {
                        HStack {
                            Image(getRouteImageName(route: route))
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .trailing)
                            Spacer()
                            Text(route.name)
                                .foregroundColor(isRouteSelected(route: route) ? Color.green : Color.white)
                            Spacer()
                            Image("next")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .leading)
                        }
                        
                    }
                }.disabled(isRouteSelected(route: route))
            }
        }
        .navigationDestination(for: Route.self) { r in
            RouteSelectConfirmView(route: r)
        }
        
    }
    func getRouteImageName(route: Route) -> String {
        if route.routeId == db.userInfo.routeSelected {
            return "checked-on"
        } else {
            return "checked-off"
        }
    }
    func isRouteSelected(route: Route) -> Bool {
        if route.routeId == db.userInfo.routeSelected {
            return true
        } else {
            return false
        }
    }
}

struct RouteSelectView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSelectView(routeArray: [Route(routeId: "LC000001")]
        )
    }
}
