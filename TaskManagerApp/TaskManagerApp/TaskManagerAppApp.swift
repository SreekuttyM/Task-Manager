//
//  TaskManagerAppApp.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

@main
struct TaskManagerAppApp: App {
    @StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            TAppView()
                .environmentObject(themeManager)
        }
    }
}
