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
//            Text(NSLocalizedString("Memo vocal", comment: ""))
            List{
                ForEach(memoVocals) { memoVocal in
                    NavigationLink(value: memoVocal) {
                        HStack {
//                            VStack {
//                                if let type = memoVocal.type {
//                                    Text(NSLocalizedString(type, comment: ""))
//                                        .font(Font.subheadline)
//                                        .foregroundColor(Color.purple)
//                                } else {
//                                    Text(NSLocalizedString("Memo vocal", comment: ""))
//                                        .font(Font.subheadline)
//                                        .foregroundColor(Color.purple)
//                                }
//                                if let createdAt = memoVocal.createdAt {
//                                    Text(createdAt.toString(dateFormat: "YY-MM-dd hh:mm"))
//                                        .font(Font.caption2)
//                                    if let createdFrom = memoVocal.createdFrom {
//                                        HStack{
//                                            Text("\(NSLocalizedString("duration", comment: "")) : ")
//                                                .font(Font.caption2)
//                                                .foregroundColor(.gray)
//                                            Text("\(DateComponentsFormatter.positional.string(from: createdAt.timeIntervalSince(createdFrom)) ?? "0:00")")
//                                                .font(Font.caption2)
//                                                .foregroundColor(.yellow)
//                                        }
//                                    }
//                                }
//                            }
                            MemoHeaderView(memoVocal: memoVocal)
                            Spacer()
                            Image("next")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .leading)
                        }
                    }
                }
                .onDelete(perform: deleteMemo)
                .listRowInsets(EdgeInsets(top: 5, leading: 7, bottom: 10, trailing: 0))
            }
//            .listRowInsets(EdgeInsets(top: 30, leading: 0, bottom: 50, trailing: 0))
            .navigationDestination(for: MemoVocal.self) { m in
                MemoVocalView(memoVocal: m)
            }
        }
    }
    func deleteMemo(at offsets: IndexSet) {
        for offset in offsets {
            let memo = memoVocals[offset]
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
        MemoVocalListView()
    }
}
