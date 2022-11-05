//
//  ReportPocInfo.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
import SwiftUI

class ReportPocInfo: NSObject, Identifiable {
    let id = UUID()
    var pocId: String
    var address: String
    var codeId: String
    var codeName: String
    var seqPosTot: Int
    var color: Color {
        switch tier {
        case 1:
            return Color.orange
        case 2:
            return Color.pink
        case 3:
            return Color.blue
        default:
            return Color.orange
        }
    }
    var tier: Int
    var type: PdrType
    var tpType: PdrTpType
    init(pocId: String, address: String, codeId: String, codeName: String, seqPosTot: Int, tier: Int, type: PdrType, tpType: PdrTpType) {
        self.pocId = pocId
        self.address = address
        self.codeId = codeId
        self.codeName = codeName
        self.seqPosTot = seqPosTot
        self.tier = tier
        self.type = type
        self.tpType = tpType
    }
//    init(pocId: String, address: String, codeId: String, codeName: String, seqPosTot: Int, color: Color, tier: Int) {
//        self.pocId = pocId
//        self.address = address
//        self.codeId = codeId
//        self.codeName = codeName
//        self.seqPosTot = seqPosTot
//        self.color = color
//        self.tier = tier
//    }

//    init(pocId: String) {
//        self.pocId = pocId
//    }
//    init(pocId: String, address: String) {
//        self.pocId = pocId
//        self.address = address
//    }
    
    init(dictionaryFormat: NSDictionary) {
        if let pocId = dictionaryFormat["pocId"] as? String {
            self.pocId = pocId
        } else {
            self.pocId = ""
        }
        if let address = dictionaryFormat["address"] as? String {
            self.address = address
        } else {
            self.address = ""
        }
        if let codeId = dictionaryFormat["codeId"] as? String {
            self.codeId = codeId
        } else {
            self.codeId = ""
        }
        if let codeName = dictionaryFormat["codeName"] as? String {
            self.codeName = codeName
        } else {
            self.codeName = ""
        }
        if let seqPosTot = dictionaryFormat["seqPosTot"] as? Int {
            self.seqPosTot = seqPosTot
        } else {
            self.seqPosTot = 0
        }
        if let tier = dictionaryFormat["tier"] as? Int {
            self.tier = tier
        } else {
            self.tier = 1
        }
        if let type = dictionaryFormat["type"] as? String {
            self.type = PdrType.domicile.getTypefromText(type: type)
        } else {
            self.type = PdrType.domicile
        }
                            
        if let tpType = dictionaryFormat["tpType"] as? String {
            self.tpType = PdrTpType.dtd.getTypefromText(type: tpType)
        } else {
            self.tpType = PdrTpType.dtd
        }
    }
    func getDictionaryFormat() -> NSDictionary {
        return [
            "pocId": self.pocId,
            "address": self.address,
            "codeId": self.codeId,
            "codeName": self.codeName,
            "seqPosTot": self.seqPosTot,

            "tier": self.tier,
            "type": self.type.getTypeInText(),
            "tpType": self.tpType.getTypeInText()
        ]
    }

}
