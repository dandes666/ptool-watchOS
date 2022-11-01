//
//  Memo.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-20.
//

import Foundation
import CoreLocation

class Memo: NSObject, Identifiable {
    let id: UUID
    let officeId: String
    let routeId: String
    let fileURL: URL
    let createdAt: Date
    let createdFrom: Date
    var downloadURL: URL? = nil
    let type: MemoType

    var adviseAt: Date? = nil
    var active: Bool
    init(id: UUID, type: MemoType, officeId: String, routeId: String, fileURL: URL,downloadURL: URL?, createdAt: Date, createdFrom:Date, adviseAt: Date?, active: Bool) {
        self.id = id
        self.officeId = officeId
        self.routeId = routeId
        self.fileURL = fileURL
        self.adviseAt = adviseAt ?? nil
        self.downloadURL = downloadURL ?? nil
        self.createdAt = createdAt
        self.createdFrom = createdFrom
        self.active = active
        self.type = type
    }
    func duration() -> CGFloat {
        return createdAt.timeIntervalSince(createdFrom)
    }
    func durationString() -> String {
        return DateComponentsFormatter.positional.string(from: self.duration()) ?? "0:00"
        
    }
}
