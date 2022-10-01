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
        Text("Produit par")
            .font(.system(size: 10))
            .padding(10)
        HStack {
            Image("PTOOL-LOGO")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
            Text("PTOOL")
        }
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
