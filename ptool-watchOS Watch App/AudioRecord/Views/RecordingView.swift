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
            Text("\(NSLocalizedString("Creer le", comment: "")) : \(rec.createdAt.toString(dateFormat: "yy-mm-dd hh:mm:ss"))")
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        let fileUrl = URL(filePath: "file///Users/davethibeault/Library/Developer/CoreSimulator/Devices/6E6304FF-E3C6-435A-A1E9-D60AB73D216B/data/Containers/Data/Application/8B41AECC-A9AF-44E9-833A-2EEE894966A8/Documents/")
        RecordingView(rec: Recording(fileURL: fileUrl, createdAt: Date(), fileName: "Nom du fichier", dowloadURL: nil))
    }
}
