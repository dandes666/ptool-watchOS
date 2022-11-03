//
//  MemoView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct MemoView: View {
    var memo: Memo?
    var memoVocal: MemoVocal?
    var body: some View {
        VStack {
            MemoHeaderView(memo: memo, memoVocal: memoVocal)
            HStack {
                if let m = memo {
                    if let url = m.fileURL {
                        AudioPlayerView(url: url, mode: .buttonPLayAndTimeleft, autoStart: false)
                            .frame(height: 90, alignment: .leading)
                    } else if let url2 = m.downloadURL {
                        AudioPlayerView(url: url2, mode: .buttonPLayAndTimeleft, autoStart: false)
                            .frame(height: 90, alignment: .center)
                    }
                }
                if let m = memo {
                    if let url = m.fileURL {
                        AudioPlayerView(url: url, mode: .buttonPLayAndTimeleft, autoStart: false)
                            .frame(height: 90, alignment: .leading)
                    } else if let url2 = m.downloadURL {
                        AudioPlayerView(url: url2, mode: .buttonPLayAndTimeleft, autoStart: false)
                            .frame(height: 90, alignment: .center)
                    }
                }
            }
//            if let m1 = memoVocal {
//                if let url3 = m1.fileURL {
//                    AudioPlayerView(url: url3, mode: .buttonAndDetail)
//                }
//            }
            
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(memo: Memo(id: UUID(), type: MemoType.officeReminder, officeId: "officeId123", routeId: "", fileURL: URL(filePath: "/"), downloadURL: nil, createdAt: Date(), createdFrom: Date(), adviseAt: Date(), active: true))
    }
}
