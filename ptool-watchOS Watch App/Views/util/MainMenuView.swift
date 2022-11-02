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
                        // ligne haut
                        HStack {
                            NavigationLink(value: MasterRoute.deliveryNoteList) {
                                ZStack {
                                    //                                Image("menu-note")
                                    Image(systemName: "clipboard")
                                        .resizable()
                                        .foregroundColor(Color.yellow)
                                        .scaledToFit()
                                    Text("\(db.deliveryNoteArray.count)")
                                        .position(CGPoint(x: geometry.size.width * 0.2, y: 30))
                                        .font(Font.title3)
                                }
                                
                            }
                            //                            .buttonStyle(.plain)
                            NavigationLink(value: MasterRoute.reportList) {
                                ZStack {
                                    //                                Image("menu-alert")
                                    Image(systemName: "clipboard")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.red)
                                    Text("\(db.getProximityRepportArray().count)")
                                        .position(CGPoint(x: geometry.size.width * 0.2  , y: 30))
                                    //                                        .position(CGPoint.centered)
                                        .font(Font.title3)
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
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
                                    } else {
                                        Text("-----")
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
                                    }
                                    
                                } else {
                                    Text("-----")
                                        .frame(width: geometry.size.width * 0.43, alignment: .center)
                                }
                            } else {
                                Text("-----")
                                    .foregroundColor(Color.red)
                                    .frame(width: geometry.size.width * 0.43, alignment: .center)
                            }
                            Spacer()
                            if (db.isPoximityReportActive && (db.reportArray.count > 0)) {
                                if let myLocation = db.lastLocation {
                                    if let rLocation = db.reportArray[0].gps {
                                        Text(db.getCleanDistanceDislpayMax100(loc1: rLocation, loc2: myLocation))
                                            .foregroundColor(Color.green)
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
                                    } else {
                                        Text("-----")
                                            .foregroundColor(Color.red)
                                            .frame(width: geometry.size.width * 0.43, alignment: .center)
                                    }
                                } else {
                                    Text("-----")
                                        .foregroundColor(Color.red)
                                        .frame(width: geometry.size.width * 0.43, alignment: .center)
                                }
                            } else {
                                Text("-----")
                                    .foregroundColor(Color.red)
                                    .frame(width: geometry.size.width * 0.43, alignment: .center)
                            }
                        }
                        // ligne Bas
                        HStack {
                            NavigationLink(value: MasterRoute.config) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.gray)
                            }
                            
                            NavigationLink(value: MasterRoute.tool) {
                                Image(systemName: "square.and.arrow.down.on.square")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.green)
                            }
                        }
                        
                    }

    
                    .navigationDestination(for: MasterRoute.self) { r in
                        switch r {
                        case .tool:
                            toolMenuView()
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
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("\(db.getCurrentRouteName())-\(db.getCurrentOfficeName())")
                }

                if router.path.count < 1 {
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
        MainMenuView()
            .environmentObject(AppManager())
            .environmentObject(Router())
    }
}
