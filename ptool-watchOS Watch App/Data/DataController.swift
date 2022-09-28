//
//  DataController.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-26.
//
import Foundation
import CoreData

class DataController: ObservableObject {
    @Published var userInfo = User(isEmpty: true)
    @Published var officeArray: [Office] = []
    @Published var reportArray: [Report] = []
//    init() {
//        var userId = "testtest"
//        var empId = "testtest"
//        var fName = "testtest"
//        var lName  = "testtest"
//        var type = 0
//        var officeSelected = "testtest"
//        var routeSelected = "testtest"
//        self.userInfo = User(userId, empId, fName ,lName, type, officeSelected, routeSelected)
//        self.officeArray = []
//        self.reportArray = []
//
//    }
    func loadUserInfo(userInfo: User) {
        self.userInfo = userInfo
    }
    func loadOfficeArray(officeArray: [Office]) {
        self.officeArray = officeArray
    }
    func loadUserInfo(reportArray: [Report]) {
        self.reportArray = reportArray
    }
    func loadData(result: String) {
        print(result)
    }
}
