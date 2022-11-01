//
//  MemoListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-26.
//

import SwiftUI

struct MemoListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdAt, order: .reverse)]) var memoVocals: FetchedResults<MemoVocal>
    var body: some View {
        VStack {
            Text("Rappel pour bureau")
            List{
                ForEach(memoVocals) { memoVocal in
                    MemoView(memo: nil, memoVocal: memoVocal)
                }
                .onDelete(perform: deleteMemo)
            }
        }
    }
    func deleteMemo(at offsets: IndexSet) {
        for offset in offsets {
            let memo = memoVocals[offset]
            if let url = memo.url {
                print("delete file")
                try? FileManager.default.removeItem(at: url)
            }
            moc.delete(memo)
        }
        try? moc.save()
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
