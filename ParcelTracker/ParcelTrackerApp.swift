//
//  ParcelTrackerApp.swift
//  ParcelTracker
//
//  Created by Hash on 2022/08/25.
//

import SwiftUI

@main
struct ParcelTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
