//
//  MotherView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase
import UserNotifications

struct MotherView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
        switch db.currentPage {
        case .signInPage:
            SignInView()
        case .homePage:
            HomeView()
        case .welcomePage:
            WelcomeView()
        case .loadingPage:
            LoadingView(title: NSLocalizedString("Chargement", comment: ""))
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(AppManager())
    }
}
