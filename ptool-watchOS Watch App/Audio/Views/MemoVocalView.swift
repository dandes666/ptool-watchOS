//
//  MemoVocalView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-31.
//

import SwiftUI

struct MemoVocalView: View {
    var memoVocal: MemoVocal
    var body: some View {
        VStack {
            Text(NSLocalizedString("Memo vocal", comment: ""))
            if let createDate = memoVocal.createdAt {
                Text("\(NSLocalizedString("Creer le", comment: "")) : \(createDate.toString(dateFormat: "YY-MM-dd hh:mm"))")
            }
            Spacer()
            if let url = memoVocal.url {
                AudioPlayerView(url: url, mode: .buttonAndDetail, height: 50, width: 50)
            } else {
                Text("trace pas url")
//                Text(memoVocal.url)
            }
        }
        
    }
}

struct MemoVocalView_Previews: PreviewProvider {
    static var previews: some View {
        MemoVocalView(memoVocal: MemoVocal())
    }
}
