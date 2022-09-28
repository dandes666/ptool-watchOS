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
    @EnvironmentObject var ptooldb: DataController
    
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
    func loadResultData(result: NSDictionary) {
//        print(result)
        if let u = result["userInfo"] as? NSDictionary {
            
            if let userId = u["userId"] as? String {
                ptooldb.userInfo.userId = userId
            }
            if let empId = u["empId"] as? String {
                ptooldb.userInfo.empId = empId
            }
            if let fName = u["fName"] as? String {
                ptooldb.userInfo.fName = fName
            }
            if let lName = u["lName"] as? String {
                ptooldb.userInfo.lName = lName
            }
            if let userType = u["userType"] as? Int {
                ptooldb.userInfo.userType = userType
            }
            
            if let woData = u["watchOSData"] as? NSDictionary {
                if let officeId = woData["officeId"] as? String {
                    ptooldb.userInfo.officeSelected = officeId
                }
                if let routeId = woData["routeId"] as? String {
                    ptooldb.userInfo.routeSelected = routeId
                }
            }
        }
        if let u = result["officeInfo"] as? NSArray {
            var offArray = <#T##[Office]#>
            for off in u {
                if let office = off as? NSDictionary {
                    if let officeId = office["id"] as? String {
                        var o = Office(officeId: officeId)
                        if let address = office["address"] as? String {
                            o.address = address
                        }
                        if let oName = office["name"] as? String {
                            o.name = oName
                        }
                        if let rArray = office["routeInfo"] as? NSArray {
                            for rou in rArray {
                                if let route = rou as? NSDictionary {
                                    if let routeId = route["id"] as? String {
                                        var r = Route(routeId: routeId)
                                        if let rName = route["name"] as? String {
                                            r.setName(name: rName)
                                        }
                                        if let rType = route["type"] as? Int {
                                            r.setType(type: rType)
                                        }
                                        o.routeArray += [r]
                                    }
                                }
                                
                            }
                        }
                        offArray += [o]
                    }
                }
                
            }
            ptooldb.loadOfficeArray(officeArray: offArray)
        }
        print(ptooldb.officeArray)
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
                    loadResultData(result: data)
                    
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
