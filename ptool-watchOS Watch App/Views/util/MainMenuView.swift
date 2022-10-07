//
//  MainMenuView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-04.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var db: AppManager
    var title1: String
    var title2: String
//    @Binding var isOn: Bool
//    var title3: String
//    var guardianActive: Bool

    var body: some View {
        NavigationView() {
            VStack {
//                Text(title2)
                VStack {
                    HStack {
                        NavigationLink(destination: DeliveryNoteListView()) {
                            ZStack {
                                Image("menu-note")
                                    .resizable()
                                    .scaledToFit()
                                Text("\(db.deliveryNoteArray.count)")
                                    .position(CGPoint(x: 60, y: 5))
                            }
                            
                        }
                        
                        NavigationLink(destination: ReportListView()) {
                            ZStack {
                                Image("menu-alert")
                                    .resizable()
                                    .scaledToFit()
                                Text("\(db.reportArray.count)")
                                    .position(CGPoint(x: 60, y: 5))
                            }
                            
                        }
                    }
                    HStack {
                        if db.isPoximityDeleveryNoteActive {
                            Text("800m")
                                .foregroundColor(Color.green)
                                .frame(width: 60, height: 25, alignment: .center)
                        } else {
                            Text("Inactif")
                                .foregroundColor(Color.red)
                                .frame(width: 60, height: 25, alignment: .center)
                        }
                        if db.guardianActive == true {
                            Image("guardian-on")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                        } else {
                            Image("guardian-off")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                        }
                        if db.isPoximityReportActive {
                            Text("800m")
                                .foregroundColor(Color.green)
                                .frame(width: 60, height: 25, alignment: .center)
                        } else {
                            Text("Inactif")
                                .foregroundColor(Color.red)
                                .frame(width: 60, height: 25, alignment: .center)
                        }
                    }

                    HStack {
                        
                        NavigationLink(destination: ConfigView(isGuardianActive: $db.guardianActive)) {
                                
                                Image("menu-config")
                                    .resizable()
                                    .scaledToFit()
//                                }
                        }
                        NavigationLink(destination: DeliveryNoteListView()) {
                            Image("menu-micro")
                                .resizable()
                                .scaledToFit()
//                                Text("Signaler")
                        }
                    }
                    
                }
//                    .navigationTitle("\(db.officeArray[db.userInfo.officeIdx].name) - \(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title1)
            
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(title1: "LC00049", title2: "Levis-Facteur")
    }
}
