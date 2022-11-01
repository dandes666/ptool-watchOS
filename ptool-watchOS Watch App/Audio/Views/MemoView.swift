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
        HStack {
            if let url = memo?.fileURL {
                MemoPlayerView(url: url)
            } else if let url = memoVocal?.url {
                MemoPlayerView(url: url)
            }
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(memo: Memo(id: UUID(), type: MemoType.officeReminder, officeId: "officeId123", routeId: "", fileURL: URL(filePath: "/"), downloadURL: nil, createdAt: Date(), createdFrom: Date(), adviseAt: Date(), active: true))
    }
}
