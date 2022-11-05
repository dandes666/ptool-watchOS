//
//  Extensions.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-15.
//

import Foundation
import SwiftUI

extension PdrType
{
    func getTypeInText() -> String {
        switch self {
        case .domicile:
            return "Hou/Dom"
        case .appartement:
            return "Apt/App"
        case .commerce:
            return "Bus/com"
        case .ferme:
            return "Frm/Frm"
        }
    }
    func getTypefromText(type: String) -> PdrType {
        switch type {
        case "Hou/Dom":
            return .domicile
        case "Apt/App":
            return .appartement
        case "Bus/com":
            return .commerce
        case "Frm/Frm":
            return .ferme
        default:
            return .ferme
        }
    }
}
extension PdrTpType
{
    func getTypeInText() -> String {
        switch self {
        case .dtd:
            return "dtd"
        case .cmb:
            return "cmb"
        case .lba:
            return "lba"
        case .aptlba:
            return "aptlba"
        case .ksk:
            return "ksk"
        case .dflb:
            return "dflb"
        case .rmb:
            return "rmb"
        case .cntr:
            return "cntr"

        }
    }
    func getTypefromText(type: String) -> PdrTpType {
        switch type {
        case "dtd":
            return .dtd
        case "cmb":
            return .cmb
        case "lba":
            return .lba
        case "aptlba":
            return .aptlba
        case "ksk":
            return .ksk
        case "dflb":
            return .dflb
        case "rmb":
            return .rmb
        case "cntr":
            return .cntr
        default:
            return .dtd
        }
    }
}
extension MemoVocal
{
    var color: Color
    {
        switch self.memoType {
        case .officeReminder:
            return Color.purple
        case .messToSupervisor:
            return Color.brown
        case .messToComiteMixte:
            return Color.blue
        case .memoOnly:
            return Color.cyan
        }
    }
    var memoType: MemoType
    {
        switch self.type {
        case "OFFICE-REMINDER":
            return .officeReminder
        case "SUPERVISOR-SENT":
            return .messToSupervisor
        case "COMITEMIXTE-SENT":
            return .messToComiteMixte
        case .none:
            return .memoOnly
        case .some(_):
            return .memoOnly
        }
    }
    func duration() -> CGFloat {
        if let createdAt = self.createdAt {
            if let createdFrom = self.createdFrom {
                return createdAt.timeIntervalSince(createdFrom)
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    func durationString() -> String {
        return DateComponentsFormatter.positional.string(from: self.duration()) ?? "0:00"
        
    }
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
}
extension DateComponentsFormatter {
    static let abbreviated: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    static let positional: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
extension Int
{
    var string:String {
        get {
            return String(self)
        }
    }
}

