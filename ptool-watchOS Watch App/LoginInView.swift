//
//  LoginInView.swift
//  ptool-watchOS
//
//  Created by Dave Thibeault on 2022-09-14.
//

import SwiftUI
import Firebase

struct LoginInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var user: User?
    @State private var showMain = false
    func handleLogin(uName: String, pwd: String) {
        print(uName)
    }
    var body: some View {
        TextField("Email", text: $email)
            .font(.title3)
//            .textContentType(right)
//            .disableAutocorrection(true)
//            .border(Color(UIColor.separator))
        SecureField("Password", text: $password)
            .font(.title3)
//        .border(Color(UIColor.separator))

        Button(action: { login() }) {
            Text("Sign in")
        }

    }
    func login() {
       Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
           if error != nil {
               print(error?.localizedDescription ?? "")
           } else {
               print("success")
           }
       }
   }
}

struct LoginInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInView()
    }
}
