//
//  RecordingDataModel.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-15.
//

import Foundation
struct Recording: Hashable, Identifiable {
    let id = UUID()
    let fileURL: URL
    // createFrom est la date de debut de l'enregistrement
    let createdFrom: Date
    let createdAt: Date
    var fileName: String?
    var dowloadURL: String?
}
