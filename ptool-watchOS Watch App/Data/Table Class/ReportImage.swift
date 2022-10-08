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
    init(dictionaryFormat: NSDictionary) {
        if let url = dictionaryFormat["url"] as? String {
            self.url = url
        } else {
            self.url = ""
        }
        if let fullPath = dictionaryFormat["fullPath"] as? String {
            self.fullPath = fullPath
        } else {
            self.fullPath = ""
        }
        if let isPrimary = dictionaryFormat["isPrimary"] as? Bool {
            self.isPrimary = isPrimary
        } else {
            self.isPrimary = false
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "url": self.url,
            "fullPath": self.fullPath,
            "isPrimary": self.isPrimary
        ]
    }

}
