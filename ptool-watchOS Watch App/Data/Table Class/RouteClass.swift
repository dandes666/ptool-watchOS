//
//  RouteClass.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-01.
//

import Foundation
class Route: NSObject {
    var routeId: String
    var name: String
    var type: Int
    var active: Bool
    

    init(routeId: String) {
        self.routeId = routeId
        self.name = ""
        self.type = 0
        self.active = false
    }

    func setAll(routeId: String, name: String, type: Int) {
        self.routeId = routeId
        self.name = name
        self.type = type
        self.active = true
    }
    func setName(name: String) {
        self.name = name
        if self.type != 0 {
            self.active = true
        }
    }
    func setType(type: Int) {
        self.type = type
        if self.name != "" {
            self.active = true
        }
    }
}
