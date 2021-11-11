//
//  FoozyApp.swift
//  Foozy
//
//  Created by Jeff Deng on 11/10/21.
//

import SwiftUI

@main
struct FoozyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
