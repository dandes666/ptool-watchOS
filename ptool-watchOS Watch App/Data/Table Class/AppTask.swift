//
//  AppTask.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-11-01.
//

import Foundation
import Combine

class AppTask: NSObject, Identifiable {
    let objectWillChange = PassthroughSubject<Void, Never>()
    let id = UUID()
    @Published var status: TaskStatus {
        willSet { objectWillChange.send() }
    }
    @Published var title: String?
    @Published var error: NSError?
    @Published var message: String? {
        willSet { objectWillChange.send() }
    }
    @Published var resultString1: String?
    @Published var progress: Double? {
        willSet { objectWillChange.send() }
    }
    @Published var resultURL: URL?
    
    
    init(status: TaskStatus?) {
        self.status = status ?? .none
    }
    
    func reset() {
        self.status = .none
        self.title = nil
        self.error = nil
        self.message = nil
        self.resultString1 = nil
        self.progress = nil
    }
}
