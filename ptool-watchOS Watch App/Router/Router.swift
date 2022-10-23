//
//  Router.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-23.
//

import SwiftUI
class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        self.path = NavigationPath()
    }
}
