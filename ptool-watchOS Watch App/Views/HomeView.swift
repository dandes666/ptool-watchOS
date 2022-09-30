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
        
        NavigationView {
            ScrollView {
                VStack {
                    Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                    Text("\(db.officeArray[db.userInfo.officeIdx].name)")
                    Text("\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
//                    HStack {
//                        Text("lat: \(userLatitude)")
//                        Text("lng: \(userLongitude)")
//                    }
                }
                Image("Logo")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                    .navigationTitle("PTOOL")
                Text("HomeView")
            }
                

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
