//
//  NotificationReportView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-02.
//

import SwiftUI

struct NotificationReportView: View {
    var title: String?
    var message: String?
    var report: Report
    var body: some View {
        ZStack {
//            Color.black
//                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    
                    if let type = report.type {
                        
                        HStack {
                            switch type {
                            case "wdog":
                                Image("Dog")
                                    .resizable()
                                //                                .scaledToFit()
                                    .frame(width: 40, height: 40, alignment: .center)
                                
                            default:
                                Image("Alert")
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                            }
                            
                            if let nTitle = title {
                                VStack {
                                    Text(nTitle)
                                    //                                    .font(.system(size: 12, weight: .light, design: .serif))
                                    //                                    .italic()
                                        .font(.headline)
                                        .lineLimit(2)
                                    //                                .font()
                                        .foregroundColor(Color.red)
                                }
                            }
                        }
                        .padding(2)
                        if let nMessage = message {
                            Text(nMessage)
                                .font(.caption)
                                .lineLimit(nil)
                                .padding(5)
                            
                        }
                    } else {
                        Text("no type")
                    }
                    if let desc = report.desc {
                        Text(desc)
                            .lineLimit(nil)
                            .padding(13)
                    }
                }
                
            }
        }
    }
}

struct NotificationReportView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationReportView(title: "Alert de Proximite", message: "Danger de Chien", report: Report(reportId: "IdREport", name: nil, desc: "Chien extérieur occasionnel", type: "dog", status: 1, gps: nil, proximityAlert: nil, imageList: nil, note: nil, pocList: nil, securedistance: nil))
    }
}
