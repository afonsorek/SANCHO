//
//  sanchoApp.swift
//  sancho
//
//  Created by Felipe Passos on 22/06/23.
//

import SwiftUI

@main
struct sanchoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
