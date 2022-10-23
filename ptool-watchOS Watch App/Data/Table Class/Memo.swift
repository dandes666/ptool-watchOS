//
//  Memo.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-20.
//

import Foundation
import CoreLocation

class Memo: NSObject, Identifiable {
    let id = UUID()
    var officeId: String
    let fileURL: URL
    let createdAt: Date
    var active: Bool
    init(officeId: String, fileURL: URL) {
        self.officeId = officeId
        self.fileURL = fileURL
        self.createdAt = Date()
        self.active = true
    }
}
