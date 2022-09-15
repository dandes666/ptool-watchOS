//
//  ptool_watchOSApp.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-13.
//

import SwiftUI
import FirebaseCore
@main
struct ptool_watchOS_Watch_AppApp: App {
    init() {
        FirebaseApp.configure()
      }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
