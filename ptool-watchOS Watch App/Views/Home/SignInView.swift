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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var memoVocals: FetchedResults<MemoVocal>
    
    @EnvironmentObject var db: AppManager
    
    @State var email = "dave.thibeault@me.com"
    @State var password = "chr1st1naT"
//    @State var email = ""
//    @State var password = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
//    lazy var functions = Functions.functions()
    
    var body: some View {
        ScrollView {
            VStack() {
                //            LogoView()
                //            Spacer()
//                Image("Logo")
//                    .resizable()
//                    .frame(width: 40, height: 40, alignment: .topLeading)
                SignInCredentialFields(email: $email, password: $password)
                if signInErrorMessage != "" {
                    Text(signInErrorMessage)
                        .font(Font.caption)
                        .foregroundColor(Color.red)
                }
                Button(action: {
                    signInUser(userEmail: email, userPassword: password)
                }) {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .topLeading)
                        Spacer()
                        Text(NSLocalizedString("Connection", comment: ""))
                            .bold()
                        //                        .frame(width: 360, height: 50)
//                            .cornerRadius(10)
                        Spacer()
                    }
                }
                .foregroundColor(getConnectionTextColor())
                .padding(.top, 10)
                .disabled(email == "" || password == "")
            }
            .padding()
        }
    }
    func getConnectionTextColor() -> Color {
        if self.email == "" || self.password == "" {
            return Color.red
        } else {
            return Color.green
        }
    }
    func completion(value: AnyObject?, error: NSError) {
        print("completion")
        print(error.localizedDescription)
        
        print(type(of: value))
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
//                print("User signed in")

                signInProcessing = false
                
                
                let user = Auth.auth().currentUser
                if let user = user {
                    let uid = user.uid
                    let uemail = user.email
                    db.loadUserData(uid: uid, uemail: uemail!)
                    for m in memoVocals {
//                        print(m.userId)
                        if let muid = m.userId {
                            print(muid)
                            if (muid == uid) {
                                print(muid)
                                if let memoId = m.id {
                                    db.memoArray += [Memo(id: memoId, type: db.getMemoTypeFromString(mString: m.type ?? ""), officeId: m.officeId ?? "", routeId: m.routeId ?? "", fileURL: m.url ?? URL(filePath: ""), downloadURL: m.downloadURL, createdAt: m.createdAt ?? Date(), createdFrom: m.createdFrom ?? Date(), adviseAt: m.adviseAt, active: m.active)]
                                }
                            }
                        }
                        
                    }
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
            TextField(NSLocalizedString("Email", comment: ""), text: $email)
//                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField(NSLocalizedString("Password", comment: ""), text: $password)
//                .padding()
//                .background(.thinMaterial)
                .cornerRadius(10)
//                .padding(.bottom, 30)
        }
    }
}
