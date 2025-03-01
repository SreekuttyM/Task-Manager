//
//  TaskManagerAppApp.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

@main
struct TaskManagerAppApp: App {
    let coreDataManager = CommandLine.arguments.contains("--uitesting") ? CoreDataTestManager() : CoreDataManager()
    init() {

        if CommandLine.arguments.contains("--resetOnboarding") {
            UserDefaults.standard.set(false, forKey: "show_home")
        } else if CommandLine.arguments.contains("--skipOnboarding") {
            UserDefaults.standard.set(true, forKey: "show_home")
        }
        if CommandLine.arguments.contains("--uitesting") {
            coreDataManager.clearData()
            coreDataManager.seedTestData()
        }

    }
    @StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            TAppView(coreDataManager: coreDataManager)
                .environmentObject(themeManager)
        }
    }
}
