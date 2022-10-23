//
//  WelcomeView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
        PtoolLogoView(imageWidth: 60, imageHeight: 60)
            .padding(20)
        Button(action: goLogin){
            Text(NSLocalizedString("enter", comment: ""))
        }
        Text(NSLocalizedString("prodBy", comment: ""))
            .font(.system(size: 10))
            .padding(10)
        HStack {
            Image(NSLocalizedString("PTOOL-LOGO", comment: ""))
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
            Text("PTOOL")
        }
    }
    func goLogin() {
        withAnimation {
            db.currentPage = .signInPage
        }
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
