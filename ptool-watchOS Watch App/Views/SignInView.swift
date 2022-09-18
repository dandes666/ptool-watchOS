//
//  SignInView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    var body: some View {
        VStack() {
//            LogoView()
//            Spacer()
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
//                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Sign Up")
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                signInProcessing = false
            case .some(_):
                print("User signed in")

                signInProcessing = false
                let user = Auth.auth().currentUser
                if let user = user {
                  // The user's ID, unique to the Firebase project.
                  // Do NOT use this value to authenticate with your backend server,
                  // if you have one. Use getTokenWithCompletion:completion: instead.
                  let uid = user.uid
                  let uemail = user.email
//                  let photoURL = user.photoURL

                    print("email = \(String(describing: uemail))")
                    print("uid = \(uid)")
//                    print(multiFactorString)
                  // ...
                }
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
//                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
//                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
//                .padding(.bottom, 30)
        }
    }
}
