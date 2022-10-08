//
//  HomeView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var db: AppManager
    @EnvironmentObject var viewRouter: ViewRouter
//    @StateObject var locationManager = LocationManager()
        
//    var userLatitude: String {
//        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
//    }
//    
//    var userLongitude: String {
//        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
//    }
     
    var dataLoading: Bool = true
//    @frozen struct RadialGradient
    var body: some View {
        
        let title1: String = "\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)-\(db.officeArray[db.userInfo.officeIdx].name)"
        let title2: String = "\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name) - \(db.officeArray[db.userInfo.officeIdx].name)"

        MainMenuView(title1: title1, title2: title2)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
