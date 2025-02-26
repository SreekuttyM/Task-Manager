//
//  TaskListView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        ZStack {
            GradientBackgroundView(colors: [theme.selectedTheme.accentColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor])
        }
    }
}

#Preview {
    TaskListView()
}
