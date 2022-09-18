//
//  ContentView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .imageScale(.small)
                .foregroundColor(.accentColor)
            NavigationLink("Login", destination: LoginInView())
            NavigationView {
                Text("Hello, World!")
                    .navigationTitle("Navigation")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
