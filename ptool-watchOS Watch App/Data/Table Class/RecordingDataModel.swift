//
//  RecordingDataModel.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-15.
//

import Foundation
struct Recording {
    let id = UUID()
    let fileURL: URL
    let createdAt: Date
    var fileName: String?
    var dowloadURL: String?
}
