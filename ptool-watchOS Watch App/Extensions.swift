//
//  Extensions.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-15.
//

import Foundation
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
