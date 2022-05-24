//
//  DataController.swift
//  Routine
//
//  Created by Mostafa Junayed on 5/15/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Routine")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
