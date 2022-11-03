//
//  OfficeMemoNotificationView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-02.
//

import SwiftUI

struct OfficeMemoNotificationView: View {
    var officeName: String
    var cptMemo: Int
    var body: some View {
        VStack{
            HStack {
                Text("Bureau" + " : ").font(Font.title3) +
                Text(officeName)
                    .font(Font.title3)
                    .foregroundColor(Color.blue)
                    
                    
            }
                .lineLimit(2)
                .padding(.bottom, 10)
            HStack {
                Text(NSLocalizedString("Youhave", comment: "") + " ") +
                Text(cptMemo.string)
                    .fontWeight(Font.Weight.bold)
                    .foregroundColor(Color.green) +
                Text(" " + NSLocalizedString(cptMemo > 1 ? "activeMemosForThisOffice" : "activeMemoForThisOffice", comment: ""))
            }.lineLimit(nil)
                .padding(.bottom, 15)
            Image(systemName: "waveform.and.mic")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color.green)
                .padding(.bottom, 15)
        }
    }
}

struct OfficeMemoNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        OfficeMemoNotificationView(officeName: "Levis", cptMemo: 3)
    }
}
