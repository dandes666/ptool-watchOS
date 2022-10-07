//
//  ReportImage.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
class ReportImage: NSObject {
    var url: String
    var isPrimary: Bool
    var fullPath: String
    init(url: String, fullPath:String, isPrimary: Bool) {
        self.url = url
        self.isPrimary = isPrimary
        self.fullPath = fullPath
    }

}
