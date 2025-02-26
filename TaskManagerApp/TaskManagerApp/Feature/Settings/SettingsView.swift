//
//  SettingsView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theme: ThemeManager
    @StateObject var viewModel: SettingsViewModel =  SettingsViewModel()

    var body: some View {
        ZStack {
            GradientBackgroundView(colors: [theme.selectedTheme.accentColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor]
            )
            VStack {
                Text("Change Theme")
                    .font(theme.selectedTheme.largeTitleFont)
                    .frame(height: 70, alignment: .leading)
                    .foregroundStyle(theme.selectedTheme.secondoryThemeColor)
                    .padding(.top, 40)
                colorGrid
                    .padding(.all, 20)
                bottomButton
                if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                    Text("version\(text)")
                        .font(theme.selectedTheme.subTextFont)
                        .foregroundStyle(theme.selectedTheme.secondoryThemeColor)
                }
            }
        }
        .onAppear {
            viewModel.loadColors()
        }
    }

    private var colorGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 16),
                               count: 3),
                alignment: .center,
                spacing: 10,
                pinnedViews: [.sectionHeaders],
                content: {
                    Section(content: {
                        ForEach(viewModel.colors, id: \.self) { color in
                            CircleView(color: color["color"] ?? "", themeString: color["theme"] ?? "", selectedThemeString: $viewModel.selectedThemeString, theme: _theme)
                        }
                    })
                }
            )

        }
    }

    private var bottomButton: some View {
        Button {
            // action
            theme.setTheme(viewModel.selectedThemeString)

        } label: {
            Text("CHANGE")
                .navigationActionModifier(color: theme.selectedTheme.accentColor)
        }
    }
}

struct CircleView: View {
    var color: String
    var themeString: String

    @Binding var selectedThemeString: String
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Circle()
            .fill(.white)
            .overlay(
                Color(hex: color)
                    .clipShape(Circle())
                    .padding(selectedThemeString == themeString ? 10 : 0)
            )
            .onTapGesture {
                selectedThemeString = themeString
            }

    }
}

#Preview {
    SettingsView().environmentObject(ThemeManager())
}
