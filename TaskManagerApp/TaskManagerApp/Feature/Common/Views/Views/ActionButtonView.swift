//
//  ActionButtonView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import SwiftUI

struct ActionButtonView: View {
    @EnvironmentObject var theme: ThemeManager

    var title: String
    var action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
            Button {
                action()
            } label: {
                Text(title).navigationActionModifier(color: theme.selectedTheme.accentColor)
            }
            .accessible(.button)
    }
}

#Preview {
    ActionButtonView(title: "Button") {
    }
}
