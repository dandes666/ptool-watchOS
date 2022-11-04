//
//  MemoListParam.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-04.
//

import Foundation

class MemoListParam : NSObject, Identifiable {
    let id = UUID()
    var mode: MemoListMode
    var officeId: String? = nil
    var memoType: MemoType? = nil
    var memoId: UUID? = nil
    init(mode: MemoListMode, officeId: String? = nil, memoType: MemoType? = nil, memoId: UUID? = nil) {
        self.mode = mode
        self.officeId = officeId
        self.memoType = memoType
    }
}
