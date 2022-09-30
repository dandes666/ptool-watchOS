//
//  User.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-17.
//

import Foundation

class User: NSObject {
    var userId: String
    var empId: String
    var fName: String
    var lName: String
    var userType: Int
    var officeSelected: String
    var officeIdx: Int
    var routeSelected: String
    var routeIdx: Int
    
    init(isEmpty: Bool) {
        self.userId = ""
        self.empId = ""
        self.fName = ""
        self.lName = ""
        self.userType = 0
        self.officeSelected = ""
        self.routeSelected = ""
        self.routeIdx = 0
        self.officeIdx = 0
    }
    init(userId: String, empId: String, fName: String, lName: String, userType: Int, officeSelected: String, routeSelected: String) {
        self.userId = userId
        self.empId = empId
        self.fName = fName
        self.lName = lName
        self.userType = userType
        self.officeSelected = officeSelected
        self.routeSelected = routeSelected
        self.routeIdx = 0
        self.officeIdx = 0
    }

}

