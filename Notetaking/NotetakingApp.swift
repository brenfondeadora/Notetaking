//
//  NotetakingApp.swift
//  Notetaking
//
//  Created by Brenda Saavedra  on 26/04/23.
//

import SwiftUI

@main
struct NotetakingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
