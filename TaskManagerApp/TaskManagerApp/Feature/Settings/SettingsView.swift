//
//  SettingsView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theme: ThemeManager

    var colors: [Color] = [.red, .green, .orange, .blue, .mint, .purple, .cyan, .teal, .indigo]
    @State private var selectedColor: Color?

    @State  var showSelection: Bool = false

    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Text("Change Theme")
                    .font(theme.selectedTheme.largeTitleFont)
                    .frame(alignment: .leading)
                    .foregroundStyle(TColor.secondary)
                    .padding(.top, 40)
                colorGrid
                    .padding(.all, 20)
                Spacer()
                bottomButton
                if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                    Text("Version \(text)")
                        .foregroundStyle(theme.selectedTheme.secondoryThemeColor)
                }
            }
        }
    }

    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 10,
            content: {
                Section(content: {
                    ForEach(colors, id: \.self) { color in
                        CircleView(color: color, selectedColor: $selectedColor, theme: _theme)
                    }
                })
            }
        )
    }

    private var bottomButton: some View {
        Button {
            // action

        } label: {
            Text("CHANGE")
                .navigationActionModifier()
        }
    }
}

struct CircleView: View {
    var color: Color
    @Binding var selectedColor: Color?
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Circle()
            .fill(theme.selectedTheme.accentColor)
            .overlay(
                color
                    .clipShape(Circle())
                    .padding(selectedColor == color ? 10 : 0)
            )
            .onTapGesture {
                selectedColor = color
            }

    }
}

#Preview {
    SettingsView().environmentObject(ThemeManager())
}
