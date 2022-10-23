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
    @State private var isShowDeliveryNote = false
    @State private var isShowReport = false
    @State private var isShowConfig = false
    @State private var isShowMemo = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView() {
                    
                    VStack {
                        //                Text(title2)
                        VStack {
                            // ligne haut
                            HStack {
                                NavigationLink(destination: DeliveryNoteListView(), isActive: $isShowDeliveryNote) {
                                    ZStack {
                                        //                                Image("menu-note")
                                        Image(systemName: "door.garage.open")
                                            .resizable()
                                            .foregroundColor(Color.yellow)
                                            .scaledToFit()
                                        Text("\(db.deliveryNoteArray.count)")
                                            .position(CGPoint(x: 38, y: 30))
                                            .font(Font.title2)
                                    }
                                    
                                }
                                
                                NavigationLink(destination: ReportListView(), isActive: $isShowReport) {
                                    ZStack {
                                        //                                Image("menu-alert")
                                        Image(systemName: "door.garage.open.trianglebadge.exclamationmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color.red)
                                        Text("\(db.reportArray.count)")
                                            .position(CGPoint(x: 33, y: 30))
                                            .font(Font.title2)
                                    }
                                    
                                }
                            }
                            // ligne Centre
                            HStack {
                                //                            Spacer()
                                if (db.isPoximityDeleveryNoteActive && (db.deliveryNoteArray.count > 0))  {
                                    if let myLocation = db.lastLocation {
                                        if let rLocation = db.deliveryNoteArray[0].gps {
                                            Text(db.getCleanDistanceDislpay(loc1: rLocation, loc2: myLocation))
                                                .foregroundColor(Color.green)
                                                .frame(alignment: .center)
                                            //                                            .frame(width: 60, height: 25, alignment: .center)
                                        } else {
                                            Text("-----")
                                                .frame(width: geometry.size.width * 0.5, alignment: .center)
                                        }
                                        
                                    } else {
                                        Text("-----")
                                            .frame(width: geometry.size.width * 0.5, alignment: .center)
                                    }
                                } else {
                                    Text("-----")
                                        .foregroundColor(Color.red)
                                        .frame(width: geometry.size.width * 0.5, alignment: .center)
                                    //                                    .frame(width: 60, height: 25, alignment: .center)
                                }
                                //                            if db.guardianActive == true && db.lastLocation != nil {
                                //                                //                            RadarView(width: 30, height: 30)
                                //                                //                                .frame(width: 30, height: 30, alignment: .center)
                                //                                Image("Radar")
                                //                                    .resizable()
                                //                                    .frame(width: 30, height: 30, alignment: .center)
                                //
                                //                            } else {
                                //                                Image("guardian-off")
                                //                                    .resizable()
                                //                                    .frame(width: 25, height: 25, alignment: .center)
                                //                            }
                                //                            Spacer()
                                if (db.isPoximityReportActive && (db.reportArray.count > 0)) {
                                    if let myLocation = db.lastLocation {
                                        if let rLocation = db.reportArray[0].gps {
                                            Text(db.getCleanDistanceDislpay(loc1: rLocation, loc2: myLocation))
                                                .foregroundColor(Color.green)
                                                .frame(width: geometry.size.width * 0.5, alignment: .center)
                                            //                                            .frame(width: 60, height: 25, alignment: .center)
                                        } else {
                                            Text("-----")
                                                .foregroundColor(Color.red)
                                                .frame(width: geometry.size.width * 0.5, alignment: .center)
                                            //                                            .frame(width: 60, height: 25, alignment: .center)
                                        }
                                    } else {
                                        Text("-----")
                                            .foregroundColor(Color.red)
                                            .frame(width: geometry.size.width * 0.5, alignment: .center)
                                        //                                        .frame(width: 60, height: 25, alignment: .center)
                                    }
                                } else {
                                    Text("-----")
                                        .foregroundColor(Color.red)
                                        .frame(width: geometry.size.width * 0.5, alignment: .center)
                                    //                                    .frame(width: 60, height: 25, alignment: .center)
                                }
                                //                            Spacer()
                            }
                            // ligne Bas
                            HStack {
                                
                                NavigationLink(destination: ConfigView(isGuardianActive: $db.guardianActive), isActive: $isShowConfig) {
                                    
                                    //                            Image("menu-config")
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.gray)
                                    //                                }
                                }
                                NavigationLink(destination: AudioRecorderView(audioRecorder: db.audioRecorder), isActive: $isShowMemo) {
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
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("\(db.getCurrentRouteName())-\(db.getCurrentOfficeName())")
                if !isShowMemo && !isShowConfig && !isShowDeliveryNote && !isShowReport {
                    if db.guardianActive == true && db.lastLocation != nil {
                        RadarView(width: 30, height: 30)
                    } else {
                        Image("guardian-off")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }
                
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
//        MainMenuView(title1: "LC00049", title2: "Levis-Facteur")
        MainMenuView().environmentObject(AppManager())
    }
}
