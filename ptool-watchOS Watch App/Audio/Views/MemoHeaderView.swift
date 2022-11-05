//
//  MemoHeaderView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-01.
//

import SwiftUI

struct MemoHeaderView: View {
    @EnvironmentObject var db: AppManager
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
            }

    }
}

struct MemoHeaderView_Previews: PreviewProvider {
//    private var dataController = DataController()
    static var previews: some View {
        MemoHeaderView()
            .environmentObject(AppManager())
            .environmentObject(DataController())
//            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
