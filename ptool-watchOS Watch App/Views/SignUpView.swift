//
//  SignUpView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase
struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Spacer()
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                //Sign up user using Firebase
            }) {
                Text("Sign Up")
                    .bold()
                    .frame(width: 360, height: 50)
//                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewRouter.currentPage = .signInPage
                }) {
                    Text("Log In")
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 150)
            .padding(.top, 70)
    }
}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
            SecureField("Confirm Password", text: $passwordConfirmation)
                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}

