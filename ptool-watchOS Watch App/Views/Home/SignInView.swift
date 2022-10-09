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
    
    @EnvironmentObject var db: AppManager
    
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
                .frame(width: 40, height: 40, alignment: .topLeading)
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
    func completion(value: AnyObject?, error: NSError) {
        print("completion")
        print(error.localizedDescription)
        
        print(type(of: value))
    }
    func loadUserData(uid: String, uemail: String) {
        print("trace result loadUserData")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        lazy var functions = Functions.functions()
        functions.httpsCallable("getGuardianInfo").call(["email": uemail]) { result, error in
            if let error = error as NSError? {
                print("trace 1")
                completion(value: nil, error: error)
            } else {
                if let data = result?.data as? NSDictionary {
                    db.loadResultData(result: data)
                }
            }
            withAnimation {
                viewRouter.currentPage = .homePage
            }
        }
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
                    let uid = user.uid
                    let uemail = user.email
                    loadUserData(uid: uid, uemail: uemail!)
//                  let uid = user.uid
//                  let uemail = user.email
//                  let photoURL = user.photoURL

//                    print("email = \(String(describing: uemail))")
//                    print("uid = \(uid)")
//                    print ("loadData start")
                    
                    
                }
                withAnimation {
                    db.currentPage = .loadingPage
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
