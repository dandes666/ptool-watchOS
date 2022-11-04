//
//  MemoVocalListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-31.
//

import SwiftUI

struct MemoVocalListView: View {
    @EnvironmentObject var db: AppManager
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdAt, order: .reverse)]) var memoVocals: FetchedResults<MemoVocal>
    
    var memoListParam: MemoListParam
    var mode: MemoListMode = .standart
    var filterOfficeId: String? = nil
    var filterType: MemoType? = nil
    
    var filteredMemoVocals: [MemoVocal] {
        switch memoListParam.mode {
        case .standart:
            return memoVocals.filter { $0.active }
        case .officeSelected:
            return memoVocals.filter { $0.officeId == db.userInfo.officeSelected }
        case .paramFecth:
            if let officeId = memoListParam.officeId {
                if let memoType = memoListParam.memoType {
                    let type = db.getMemoTypeString(memoType: memoType)
                    return memoVocals.filter { $0.officeId == officeId && $0.type == type }
                } else {
                    return memoVocals.filter { $0.officeId == officeId }
                }
            } else {
                if let memoType = memoListParam.memoType {
                    let type = db.getMemoTypeString(memoType: memoType)
                    return memoVocals.filter { $0.type == type }
                } else {
                    return memoVocals.filter { $0.active }
                }
            }
        case .memoSelect:
            if let memoId = memoListParam.memoId {
                return memoVocals.filter { $0.id == memoId }
            } else {
                return memoVocals.filter { $0.active }
            }
        }

    }
    var body: some View {
        VStack {
            List{
                ForEach(filteredMemoVocals) { memoVocal in
                    MemoView(memoVocal: memoVocal)
                }
                .onDelete(perform: deleteMemo)
//                .listRowInsets(EdgeInsets(top: 5, leading: 1, bottom: 40, trailing: 0))
            }
        }
    }
    func deleteMemo(at offsets: IndexSet) {
        for offset in offsets {
            let memo = filteredMemoVocals[offset]
            if let url = memo.url {
//                print("delete file")
                try? FileManager.default.removeItem(at: url)
            }
            moc.delete(memo)
        }
        try? moc.save()
    }
}

struct MemoVocalListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoVocalListView(memoListParam: MemoListParam(mode: .standart))
    }
}
