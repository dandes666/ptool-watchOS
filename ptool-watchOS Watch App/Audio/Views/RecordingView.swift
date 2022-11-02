//
//  RecordingView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-17.
//

import SwiftUI

struct RecordingView: View {
    let rec : Recording
    var body: some View {
        VStack {
            Text(NSLocalizedString("Memo vocal", comment: ""))
                .font(Font.subheadline)
                .foregroundColor(Color.purple)
            Text(rec.createdAt.toString(dateFormat: "YY-MM-dd hh:mm"))
                .font(Font.caption2)
//            Text("\(NSLocalizedString("duration", comment: "")) : \(DateComponentsFormatter.positional.string(from: rec.createdAt.timeIntervalSince(rec.createdFrom)) ?? "0:00")")
                .font(Font.caption2)
            HStack{
                Text("\(NSLocalizedString("duration", comment: "")) : ")
                    .font(Font.caption2)
                    .foregroundColor(.gray)
                Text("\(DateComponentsFormatter.positional.string(from: rec.createdAt.timeIntervalSince(rec.createdFrom)) ?? "0:00")")
                    .font(Font.caption2)
                    .foregroundColor(.yellow)
            }
            
        }
//        .padding(.leading, 10)
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        let fileUrl = URL(filePath: "file///Users/davethibeault/Library/Developer/CoreSimulator/Devices/6E6304FF-E3C6-435A-A1E9-D60AB73D216B/data/Containers/Data/Application/8B41AECC-A9AF-44E9-833A-2EEE894966A8/Documents/")
        RecordingView(rec: Recording(fileURL: fileUrl,createdFrom: Date(), createdAt: Date(), fileName: "Nom du fichier", dowloadURL: nil))
    }
}
