//
//  WelcomeView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        PtoolLogoView(imageWidth: 60, imageHeight: 60)
            .padding(20)
        Button(action: goLogin){
            Text("Connection")
        }
        Text("De PTOOL")
            .font(.system(size: 10))
            .padding(20)
    }
    func goLogin() {
        withAnimation {
            viewRouter.currentPage = .signInPage
        }
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
