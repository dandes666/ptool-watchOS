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
    var deliveryNoteDistanceText: String {
        if (db.isPoximityDeleveryNoteActive && (db.deliveryNoteArray.count > 0))  {
            if let myLocation = db.lastLocation {
                return db.getCleanDistanceDislpayMax100(loc1: db.deliveryNoteArray[0].gps, loc2: myLocation)
            } else {return ""}
        } else {return ""}
    }
    var deliveryNoteDistanceColor: Color {
        if (db.isPoximityDeleveryNoteActive && (db.deliveryNoteArray.count > 0))  {
            if let myLocation = db.lastLocation {
                if db.deliveryNoteArray[0].gps.distance(from: myLocation) < 100 {
                    return .red
                } else {
                    return .green
                }
            } else {return .green}
        } else {return .green}
    }
    var reportDistanceText: String {
        if (db.isPoximityReportActive && (db.reportArray.count > 0))  {
            if let myLocation = db.lastLocation {
                return db.getCleanDistanceDislpayMax100(loc1: db.reportArray[0].gps, loc2: myLocation)
            } else {return ""}
        } else {return ""}
    }
    var reportDistanceColor: Color {
        if (db.isPoximityDeleveryNoteActive && (db.reportArray.count > 0))  {
            if let myLocation = db.lastLocation {
                if db.reportArray[0].gps.distance(from: myLocation) < 100 {
                    return .red
                } else {
                    return .green
                }
            } else {return .green}
        } else {return .green}
    }
    var body: some View {
        ZStack {
            
            NavigationStack(path: $router.path) {
                GeometryReader { geometry in
                    VStack {
                        // ligne haut
                        HStack {
                            Spacer()
                            PlaybackControlButton(systemName: "clipboard",fontSize: geometry.size.height * 0.43, color: .yellow, labelCenter: "\(db.deliveryNoteArray.count)", labelCenterFontSize: geometry.size.width * 0.16, labelCenterColor: .yellow, labelBottom: deliveryNoteDistanceText,labelBottomFontSize: geometry.size.width * 0.08, labelBottomColor: deliveryNoteDistanceColor) {
                                router.path.append(MasterRoute.deliveryNoteList)
                            }
                            Spacer()
                            Spacer()
                            PlaybackControlButton(systemName: "clipboard",fontSize: geometry.size.height * 0.43, color: .red, labelCenter: "\(db.getProximityRepportArray().count)", labelCenterFontSize: geometry.size.width * 0.16, labelCenterColor: .red, labelBottom: reportDistanceText,labelBottomFontSize: geometry.size.width * 0.08, labelBottomColor: reportDistanceColor) {
                                router.path.append(MasterRoute.reportList)
                            }
                            Spacer()

                        }

                        HStack {
                            Spacer()
                            PlaybackControlButton(systemName: "gearshape.fill",fontSize: geometry.size.height * 0.4, color: .gray) {
                                router.path.append(MasterRoute.config)
                            }
                            Spacer()
                            Spacer()
                            PlaybackControlButton(systemName: "square.and.arrow.down.on.square",fontSize: geometry.size.height * 0.4, color: .green) {
                                router.path.append(MasterRoute.tool)
                            }
                            Spacer()
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
//                if db.guardianActive == true {
                    RadarView(width: 30, height: 30)
                        .padding(.top, 35)
                } else {
                    Image(systemName: "location.slash.fill")
                        .resizable()
//                        .padding(.top, 25)
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.top, 35)
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
