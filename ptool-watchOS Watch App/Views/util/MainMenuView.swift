//
//  MainMenuView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-04.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var db: AppManager
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationStack(path: $router.path) {
                    
                    VStack {
                        //                Text(title2)
                        VStack {
                            // ligne haut
                            HStack {
//                                NavigationLink(destination: DeliveryNoteListView(), isActive: $isShowDeliveryNote) {
                                NavigationLink(value: MasterRoute.deliveryNoteList) {
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
                                
//                                NavigationLink(destination: ReportListView(), isActive: $isShowReport) {
                                NavigationLink(value: MasterRoute.reportList) {
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
                                            Text(db.getCleanDistanceDislpayMax100(loc1: rLocation, loc2: myLocation))
                                                .foregroundColor(Color.green)
//                                                .frame(alignment: .center)
                                                .frame(width: geometry.size.width * 0.43, alignment: .center)
                                        } else {
                                            Text("-----")
                                                .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                                .frame(width: 60, height: 25, alignment: .center)
                                        }
                                        
                                    } else {
                                        Text("-----")
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                            .frame(width: 60, height: 25, alignment: .center)
                                    }
                                } else {
                                    Text("-----")
                                        .foregroundColor(Color.red)
                                        .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                        .frame(width: 60, height: 25, alignment: .center)
                                }
                                if db.guardianActive == true && db.lastLocation != nil {
                                    //                            RadarView(width: 30, height: 30)
                                    //                                .frame(width: 30, height: 30, alignment: .center)
                                    Image("Radar")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14, alignment: .center)
    
                                } else {
                                    Image("guardian-off")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14, alignment: .center)
                                }
                                //                            Spacer()
                                if (db.isPoximityReportActive && (db.reportArray.count > 0)) {
                                    if let myLocation = db.lastLocation {
                                        if let rLocation = db.reportArray[0].gps {
                                            Text(db.getCleanDistanceDislpayMax100(loc1: rLocation, loc2: myLocation))
                                                .foregroundColor(Color.green)
                                                .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                                .frame(width: 60, height: 25, alignment: .center)
                                        } else {
                                            Text("-----")
                                                .foregroundColor(Color.red)
                                                .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                                .frame(width: 60, height: 25, alignment: .center)
                                        }
                                    } else {
                                        Text("-----")
                                            .foregroundColor(Color.red)
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                            .frame(width: 60, height: 25, alignment: .center)
                                    }
                                } else {
                                    Text("-----")
                                        .foregroundColor(Color.red)
                                        .frame(width: geometry.size.width * 0.43, alignment: .center)
//                                        .frame(width: 60, height: 25, alignment: .center)
                                }
                                //                            Spacer()
                            }
                            // ligne Bas
                            HStack {
                                NavigationLink(value: MasterRoute.config) {
//                                NavigationLink(destination: ConfigView(isGuardianActive: $db.guardianActive), isActive: $isShowConfig) {
                                    
                                    //                            Image("menu-config")
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.gray)
                                    //                                }
                                }
//                                NavigationLink(destination: AudioRecorderView(audioRecorder: db.audioRecorder), isActive: $isShowMemo) {
                                NavigationLink(value: MasterRoute.memo) {
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
                    .navigationDestination(for: MasterRoute.self) { r in
                        switch r {
                        case .memo:
                            AudioRecorderView()
                        case .config:
                            ConfigView()
                        case .reportList:
                            ReportListView()
                        case .deliveryNoteList:
                            DeliveryNoteListView()
                        case .complete:
                            CompleteView(width: 130, height: 130, title: "Envoit de memo")
                        case .error:
                            ErrorView(width: 100, height: 100, title: "Erreur", desc: "")
                        }
                    }
//                    .navigationDestination(for: MasterRoute.reportList) {
//                            DeliveryNoteListView()
//                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("\(db.getCurrentRouteName())-\(db.getCurrentOfficeName())")
//                if router.path.count < 1 {
//                    if db.guardianActive == true && db.lastLocation != nil {
//                        RadarView(width: 30, height: 30)
//                    } else {
//                        Image("guardian-off")
//                            .resizable()
//                            .frame(width: 25, height: 25, alignment: .center)
//                    }
//                }
                
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
//        MainMenuView(title1: "LC00049", title2: "Levis-Facteur")
        MainMenuView()
            .environmentObject(AppManager())
            .environmentObject(Router())
    }
}
