//
//  LoginInView.swift
//  ptool-watchOS
//
//  Created by Dave Thibeault on 2022-09-14.
//

import SwiftUI

struct LoginInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    func handleLogin(uName: String, pwd: String) {
        print(uName)
    }
    var body: some View {
        TextField(
            "email",
            text: $username)
//            .autocapitalization(.none)
//            .disableAutocorrection(true)
//            .border(Color(UIColor.separator))
        SecureField(
            "Password",
            text: $password
        ) {
//            handleLogin(username, password)
        }
//        .border(Color(UIColor.separator))
    }
}

struct LoginInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInView()
    }
}
