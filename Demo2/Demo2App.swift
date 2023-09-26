//
//  Demo2App.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

@main
struct Demo2App: App {
    //new
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
