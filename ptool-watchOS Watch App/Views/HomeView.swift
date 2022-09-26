//
//  HomeView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
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
                    Text("location status: \(locationManager.statusString)")
                    HStack {
                        Text("latitude: \(userLatitude)")
                        Text("longitude: \(userLongitude)")
                    }
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
