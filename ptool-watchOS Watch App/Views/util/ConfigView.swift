//
//  ConfigView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct ConfigView: View {
    var body: some View {
        NavigationView {
            Button(action: signOutUser) {
                Text("Deconnection")
            }
            
//            NavigationLink
//            .navigationTitle("Config")
        }.navigationTitle("Config")
    }
   func signOutUser() {
        print("sign out")
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
