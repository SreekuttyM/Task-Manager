//
//  TabbedView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TabbedView: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Label("Tasks",
                        systemImage: "square.and.pencil.circle.fill")

                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabbedView()
}
