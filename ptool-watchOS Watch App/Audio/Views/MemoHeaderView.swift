//
//  MemoHeaderView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-01.
//

import SwiftUI

struct MemoHeaderView: View {
    @EnvironmentObject var db: AppManager
    var memo: Memo?
    var memoVocal: MemoVocal?
    var body: some View {
            if let memoVocal = memoVocal {
                VStack {
                    if let type = memoVocal.type {
                        Text(NSLocalizedString(type, comment: ""))
                            .font(Font.subheadline)
                            .lineSpacing(0)
                            .foregroundColor(memoVocal.color)
                    } else {
                        Text(NSLocalizedString("MEMO-ONLY", comment: ""))
                            .font(Font.subheadline)
                            .lineSpacing(0)
                            .foregroundColor(memoVocal.color)
                    }
                    if let createdAt = memoVocal.createdAt {
                        Text(createdAt.toString(dateFormat: "YY-MM-dd HH:MM"))
                            .font(Font.caption2)
                    }
                }
            } else if let memo = memo {
                VStack {

                    Text(NSLocalizedString(db.getMemoTypeString(memoType: memo.type), comment: ""))
                        .font(Font.subheadline)
                        .lineSpacing(0)
                        .foregroundColor(Color.purple)


                    Text(memo.createdAt.toString(dateFormat: "YY-MM-dd HH:MM"))
                        .font(Font.caption2)

                    HStack{
                        Text("\(NSLocalizedString("duration", comment: "")) : ")
                            .font(Font.caption2)
                            .foregroundColor(.gray)
                        Text("\(DateComponentsFormatter.positional.string(from: memo.createdAt.timeIntervalSince(memo.createdFrom)) ?? "0:00")")
                            .font(Font.caption2)
                            .foregroundColor(.yellow)
                    }

                }
            }

    }
}

struct MemoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MemoHeaderView(memo: Memo(id: UUID(), type: MemoType.messToComiteMixte, officeId: "officeId123", routeId: "", fileURL: URL(filePath: "/"), downloadURL: nil, createdAt: Date(), createdFrom: Date(), adviseAt: Date(), active: true))
            .environmentObject(AppManager())
    }
}
