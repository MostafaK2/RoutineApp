//
//  RoutineApp.swift
//  Routine
//
//  Created by Mostafa Junayed on 5/14/22.
//

import SwiftUI

@main
struct RoutineApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)

        }
    }
}
