//
//  MainMenuView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-04.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var db: AppManager
    @State private var animationActive = false
//    var title1: String
//    var title2: String
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
//                                Image("menu-note")
                                Image(systemName: "door.garage.open")
                                    .resizable()
                                    .foregroundColor(Color.yellow)
                                    .scaledToFit()
                                Text("\(db.deliveryNoteArray.count)")
                                    .position(CGPoint(x: 38, y: 34))
                                    .font(Font.title2)
                            }
                            
                        }.disabled(db.deliveryNoteArray.count == 0)
                        
                        NavigationLink(destination: ReportListView()) {
                            ZStack {
//                                Image("menu-alert")
                                Image(systemName: "door.garage.open.trianglebadge.exclamationmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.red)
                                Text("\(db.reportArray.count)")
                                    .position(CGPoint(x: 33, y: 34))
                                    .font(Font.title2)
                            }
                            
                        }
                    }
                    HStack {
                        if (db.isPoximityDeleveryNoteActive && (db.deliveryNoteArray.count > 0))  {
                            if let myLocation = db.lastLocation {
                                if let rLocation = db.deliveryNoteArray[0].gps {
                                    Text(db.getCleanDistanceDislpay(loc1: rLocation, loc2: myLocation))
                                        .foregroundColor(Color.green)
                                        .frame(width: 60, height: 25, alignment: .center)
                                } else {
                                    Text("")
                                }
                                
                            } else {
                                Text("")
                            }
                        } else {
                            Text("-----")
                                .foregroundColor(Color.red)
                                .frame(width: 60, height: 25, alignment: .center)
                        }
                        if db.guardianActive == true {
                            Image("Radar")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                            //                                .rotationEffect(Angle(degrees: self.animationActive ? 360 : 0))
                            //                    .animation(Animation.easeIn(duration: 1), value: self.isLoading)
                            //                                .frame(width: 25, height: 25, alignment: .center)
                            //                                .animation(Animation.default.repeatForever(autoreverses: false), value: self.animationActive)
                            //                        .animation(Animation.default.repeatForever(autoreverses: false))
                            //                                .rotationEffect(Angle(degrees: self.animationActive ? 360 : 0))
                            
                            //                                .onAppear() {
                            //                                    self.animationActive = true
                            //                                }
                        } else {
                            Image("guardian-off")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                        }
                        if (db.isPoximityReportActive && (db.reportArray.count > 0)) {
                            if let myLocation = db.lastLocation {
                                if let rLocation = db.reportArray[0].gps {
                                    Text(db.getCleanDistanceDislpay(loc1: rLocation, loc2: myLocation))
                                        .foregroundColor(Color.green)
                                        .frame(width: 60, height: 25, alignment: .center)
                                } else {
                                    Text("")
                                }
                            } else {
                                Text("")
                            }
                        } else {
                            Text("-----")
                                .foregroundColor(Color.red)
                                .frame(width: 60, height: 25, alignment: .center)
                        }
                    }
                    
                    HStack {
                        
                        NavigationLink(destination: ConfigView(isGuardianActive: $db.guardianActive)) {
                            
//                            Image("menu-config")
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.gray)
                            //                                }
                        }
                        NavigationLink(destination: AudioRecorderView(audioRecorder: db.audioRecorder)) {
//                            Image("menu-micro")
                            Image(systemName: "mic.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.green)
                            //                                Text("Signaler")
                        }
                    }
                    
                }
                //                    .navigationTitle("\(db.officeArray[db.userInfo.officeIdx].name) - \(db.officeArray[db.userInfo.officeIdx].routeArray[db.userInfo.routeIdx].name)")
                
            }

            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle(title1)
            .navigationTitle("\(db.getCurrentRouteName())-\(db.getCurrentOfficeName())")
            
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
//        MainMenuView(title1: "LC00049", title2: "Levis-Facteur")
        MainMenuView()
    }
}
