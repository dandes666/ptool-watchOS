//
//  HomeView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var db: DataController
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var locationManager = LocationManager()
        
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
        
      
    var dataLoading: Bool = true
//    @frozen struct RadialGradient
    var body: some View {
        NavigationView() {
            ScrollView {
                VStack {
                                        Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                    //                    Text("\(db.officeArray[db.userInfo.officeIdx].name)")
                    //                    Text("\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                    NavigationLink(destination: ConfigView()) {
                        Text("configuration")
//                        PtoolLogoView()
                    }
                    NavigationLink(destination: ReportListView()) {
                        Text("signalement(\(db.reportArray.count))")
                    }
                    
                    
                }
                .navigationTitle("\(db.officeArray[db.userInfo.officeIdx].name) - \(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                TabView() {
                    PtoolLogoView()
                }
                
                
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
