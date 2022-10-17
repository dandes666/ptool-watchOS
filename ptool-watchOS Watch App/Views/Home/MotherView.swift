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
    
//    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var db: AppManager
    var body: some View {
        switch db.currentPage {
//        case .signUpPage:
//            SignUpView()
        case .signInPage:
            SignInView()
        case .homePage:
            HomeView()
        case .welcomePage:
            WelcomeView()
        case .loadingPage:
            LoadingView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(AppManager())
    }
}
