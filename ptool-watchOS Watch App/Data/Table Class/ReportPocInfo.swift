//
//  ReportPocInfo.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
class ReportPocInfo: NSObject, Identifiable {
    var pocId: String
    var address: String?
    

    init(pocId: String) {
        self.pocId = pocId
    }
    init(pocId: String, address: String) {
        self.pocId = pocId
        self.address = address
    }
    
    init(dictionaryFormat: NSDictionary) {
        if let pocId = dictionaryFormat["pocId"] as? String {
            self.pocId = pocId
        } else {
            self.pocId = ""
        }
        if let address = dictionaryFormat["address"] as? String {
            self.address = address
        } else {
            self.address = nil
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "pocId": self.pocId,
            "address": self.getAddress()
        ]
    }
    func getAddress() -> String {
        if let add = self.address {
            return add
        } else {
            return ""
        }
    }

}
