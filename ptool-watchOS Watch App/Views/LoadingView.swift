//
//  LoadingView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-23.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
//    var dataLoading: Bool = true
    
    var body: some View {
        NavigationView {

            Image("Logo")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .navigationTitle("Loading...")
            
        }
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
