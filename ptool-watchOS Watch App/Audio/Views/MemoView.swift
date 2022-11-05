//
//  MemoView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct MemoView: View {
    var memoVocal: MemoVocal
    var body: some View {
        VStack {
            MemoHeaderView(memoVocal: memoVocal)
            Spacer()
            AudioPlayerView(url: getAudioURL(), mode: .buttonAndDetail, autoStart: false)
                .frame(height: 100)
            
        }
        
    }
    func disactiveMemo() -> Void {
        print("disactive memo")
    }
    func getAudioURL() -> URL {
        if let u3 = memoVocal.url {
            return u3
        } else if let u4 = memoVocal.downloadURL {
            return u4
        } else {
            return URL(filePath: "/")
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        let mArray: [MemoVocal] = []
//        let mArray: [Memo] = [
//            Memo(id: UUID(), type: MemoType.officeReminder, officeId: "officeId123", routeId: "", fileURL: URL(filePath: "/"), downloadURL: nil, createdAt: Date(), createdFrom: Date(), adviseAt: Date(), active: true),
//            Memo(id: UUID(), type: MemoType.officeReminder, officeId: "officeId124", routeId: "", fileURL: URL(filePath: "/"), downloadURL: nil, createdAt: Date(), createdFrom: Date(), adviseAt: Date(), active: true)
//        ]
        List{
            ForEach(mArray) { memoVocal in
                MemoView(memoVocal: memoVocal)
                    .environmentObject(AppManager())
                    .environmentObject(AudioManager())
            }
            
            .onDelete(perform: {_ in })
        }
            .listStyle(.carousel)
    }

}
