//
//  Route.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//

import Foundation
class Route: NSObject {
    var routeId: String
    var name: String
    var type: Int
    

    init(routeId: String, name: String, type: Int) {
        self.routeId = routeId
        self.name = name
        self.type = type
    }

}
