//
//  ReportNote.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
class ReportNote: NSObject {
    var note: String
    

    init(note: String) {
        self.note = note
    }
    init(dictionaryFormat: NSDictionary) {
        if let note = dictionaryFormat["note"] as? String {
            self.note = note
        } else {
            self.note = ""
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "note": self.note
        ]
    }

}
