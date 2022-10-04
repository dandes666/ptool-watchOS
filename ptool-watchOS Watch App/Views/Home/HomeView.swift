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
        NavigationView() {
            VStack {
                Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                ScrollView {
                    VStack {
//                        Text("\(db.userInfo.fName) \(db.userInfo.lName)")
                        //                    Text("\(db.officeArray[db.userInfo.officeIdx].name)")
                        //                    Text("\(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                        NavigationLink(destination: ConfigView()) {
                            Text("Configuration")
                            //                        PtoolLogoView()
                        }.padding()
                        NavigationLink(destination: ReportListView()) {
                            Text("Signalement(\(db.reportArray.count))")
                        }.padding()
                        NavigationLink(destination: DeliveryNoteListView()) {
                            Text("Note de livraison(\(db.deliveryNoteArray.count))")
                        }.padding()
                        NavigationLink(destination: DeliveryNoteListView()) {
                            Text("Signaler")
                        }.padding()
                        
                        
                    }
                    .navigationTitle("\(db.officeArray[db.userInfo.officeIdx].name) - \(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                    TabView() {
                        PtoolLogoView(imageWidth: 40, imageHeight: 40)
                    }
                    
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
