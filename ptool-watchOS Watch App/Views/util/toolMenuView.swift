//
//  toolMenuView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct toolMenuView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var db: AppManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    NavigationLink(value: ToolRoute.memo) {
                        HStack {
                            Image(systemName: "mic.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.green)
                                .frame(width: 30, height: 30, alignment: .center)
                            Spacer()
                            Text(NSLocalizedString("memocreate", comment: ""))
                                .lineLimit(3)
                                .font(Font.caption2)
                            Spacer()
                        }
                    }.padding(.bottom, 10)
                    NavigationLink(value: MemoListParam(mode: .standart)) {
                        HStack {
                            Image(systemName: "mic.and.signal.meter.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.green)
                                .frame(width: 30, height: 30, alignment: .center)
                            Spacer()
                            Text(NSLocalizedString("memolist", comment: ""))
                                .lineLimit(3)
                                .font(Font.caption2)
                            Spacer()
                        }
                    }.padding(.bottom, 10)
                    NavigationLink(value: ToolRoute.fullbox) {
                        HStack {
                            Image(systemName: "tray.full")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.green)
                                .frame(width: 30, height: 30, alignment: .center)
                            Spacer()
                            Text(NSLocalizedString("fullbox", comment: ""))
                                .lineLimit(3)
                                .font(Font.caption2)
                            Spacer()
                        }
                    }.padding(.bottom, 10)
                    
                }
            }
            .navigationDestination(for: ToolRoute.self) { r in
                switch r {
                case .memo:
                    AudioRecorderView()
//                case .memoList:
//                    MemoVocalListView()
                case .fullbox:
                    FullBoxListView()
                }
            }
            .navigationDestination(for: MemoListParam.self) { memoListParam in
                MemoVocalListView(memoListParam: memoListParam)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(NSLocalizedString("nt-home", comment: ""))
        }
    }
}

struct toolMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            toolMenuView().environmentObject(AppManager())
                .environmentObject(Router())
        }
    }
}
