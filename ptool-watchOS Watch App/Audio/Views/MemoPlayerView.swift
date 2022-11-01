//
//  MemoPlayerView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct MemoPlayerView: View {
    var memo: Memo?
    var memoVocal: MemoVocal?
    let url: URL
    var body: some View {
        if let url = memo?.fileURL {
            AudioPlayerView(url: url, height: 50, width: 50)
        } else if let url = memoVocal?.url {
            AudioPlayerView(url: url, height: 50, width: 50)
        }
    }
}

struct MemoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MemoPlayerView(url: URL(filePath: "/"))
    }
}
