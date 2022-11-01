//
//  MemoVocalListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-31.
//

import SwiftUI

struct MemoVocalListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdAt, order: .reverse)]) var memoVocals: FetchedResults<MemoVocal>
    var body: some View {
        VStack {
            Text("Rappel pour bureau")
            List{
                ForEach(memoVocals) { memoVocal in
                    //                    MemoView(memo: nil, memoVocal: memoVocal)
                    NavigationLink(value: memoVocal) {
                        VStack {
                            Text(NSLocalizedString("Memo vocal", comment: ""))
                            if let createDate = memoVocal.createdAt {
                                Text("\(NSLocalizedString("Creer le", comment: "")) : \(createDate.toString(dateFormat: "YY-MM-dd hh:mm"))")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteMemo)
            }
            .navigationDestination(for: MemoVocal.self) { m in
                MemoVocalView(memoVocal: m)
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

struct MemoVocalListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoVocalListView()
    }
}
