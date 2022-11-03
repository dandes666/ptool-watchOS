//
//  OfficeActiveMemoListView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-02.
//

import SwiftUI

struct OfficeActiveMemoListView: View {
    @EnvironmentObject var db: AppManager
    var officeId: String? = nil

    var body: some View {
        List(db.getActiveMemo(officeId: getOfficeId())) { memo in
            VStack {
                MemoView(memo: memo)
            }
        }
        .listStyle(.carousel)
        .onDisappear {
            db.officeActiveMemoListId = nil
        }
    }
    func getOfficeId() -> String? {
        if let officeId = self.officeId {
            return officeId
        } else if let officeActiveMemoListId = db.officeActiveMemoListId {
            return officeActiveMemoListId
        } else {
            return db.userInfo.officeSelected
        }
    }
}

struct OfficeActiveMemoListView_Previews: PreviewProvider {
    static var previews: some View {
        OfficeActiveMemoListView().environmentObject(AppManager())
    }
}
