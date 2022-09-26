//
//  SignInView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase
import FirebaseFunctions

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = "dave.thibeault@me.com"
    @State var password = "chr1st1naT"
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
//    lazy var functions = Functions.functions()
    
    var body: some View {
        VStack() {
//            LogoView()
//            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
                    .cornerRadius(10)
            }
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
                    print ("loadData start")
                    lazy var functions = Functions.functions()
                    functions.httpsCallable("getGuardianInfo").call(["email": uemail]) { result, error in
                        if let error = error as NSError? {
                            print("trace error2")
                            print(error)
                            if error.domain == FunctionsErrorDomain {
                                print("trace error3")
                                let code = FunctionsErrorCode(rawValue: error.code)
                              let message = error.localizedDescription
                              let details = error.userInfo[FunctionsErrorDetailsKey]
                            }
            // ...
                        }
                        if let data = result?.data as? [String: Any], let text = data["text"] as? String {
            //            self.resultField.text = text
                          print(text)
                        }
                        print("trace result")
                        print(result?.data)
                        
                        withAnimation {
                            viewRouter.currentPage = .homePage
                        }
                    }
                    
                }
                withAnimation {
                    viewRouter.currentPage = .loadingPage
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
