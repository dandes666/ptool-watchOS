//
//  DataController.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-26.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MemoModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
}
