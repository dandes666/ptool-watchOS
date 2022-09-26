//
//  ptool_watchOSApp.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-13.
//

import SwiftUI
import Firebase
@main
struct ptool_watchOS_Watch_AppApp: App {
    
    @StateObject var viewRouter = ViewRouter()
//    let var ref: DatabaseReference!
    
    
    
    init() {
        FirebaseApp.configure()
//        ref = Database.database().reference()
      }
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
//            ContentView()
        }
    }
}
