//
//  TabbedView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TabbedView: View {
    @EnvironmentObject var theme: ThemeManager
    var coreDataManager: CoreDataManager

    var body: some View {
        TabView {
            HomeScreen(coreDataManager: coreDataManager)
                .tabItem {
                    Label("Tasks",
                          systemImage: "square.and.pencil.circle.fill")
                    .accessibilityIdentifier("homeTab")

                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                        .accessibilityIdentifier("settingsTab")

                }
                .tag(2)
        }.tint(theme.selectedTheme.accentColor)
            .onAppear(perform: {
                        UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
                    })
    }

}

#Preview {
    TabbedView(coreDataManager: CoreDataManager()).environmentObject(ThemeManager())
}
