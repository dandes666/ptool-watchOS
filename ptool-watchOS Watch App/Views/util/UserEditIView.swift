//
//  UserEditIView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct UserEditIView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var db: AppManager
    let user: User
    var body: some View {
        PtoolLogoView(imageWidth: 40, imageHeight: 40)
        VStack() {
            Text("\(user.fName) \(user.lName)")
            Text("\(user.empId)")
        }.padding(4)
        Button(action: signOutUser) {
            Text("Deconnection")
        }
        
    }
    func signOutUser() {
        print("sign out")
        
        db.currentPage = .signInPage
//        db.logout()
        
    }
}

struct UserEditIView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditIView(user: User(userId: "11111", empId: "7050826", fName: "Dave", lName: "Thibeault", userType: 1, officeSelected: "offID", routeSelected: "routID"))
    }
}
