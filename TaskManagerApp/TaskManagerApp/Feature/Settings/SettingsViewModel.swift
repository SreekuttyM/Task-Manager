//
//  SettingsViewModel.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var colors: [[String: String]] = []
    @Published var selectedThemeString: String = ThemeName.red.rawValue

    init() {
        self.loadColors()
    }

    func loadColors() {
        var colors: [[String: String]] = []
        for type in ThemeName.allCases {
            switch type {
                case .main: break

                case .red:
                    colors.append(["color": "FF2600", "theme": ThemeName.red.rawValue])
                case .blue:
                    colors.append(["color": "0433FF", "theme": ThemeName.blue.rawValue])

                case .green:
                    colors.append(["color": "00F900", "theme": ThemeName.green.rawValue])

                case .cyan:
                    colors.append(["color": "FF6F61", "theme": ThemeName.cyan.rawValue])

                case .mint:
                    colors.append(["color": "2D8B17", "theme": ThemeName.mint.rawValue])

                case .indigo:
                    colors.append(["color": "000000", "theme": ThemeName.indigo.rawValue])

                case .teal:
                    colors.append(["color": "A57C61", "theme": ThemeName.teal.rawValue])

                case .purple:
                    colors.append(["color": "6A4C9C", "theme": ThemeName.purple.rawValue])

                case .orange:
                    colors.append(["color": "E9A722", "theme": ThemeName.orange.rawValue])

            }
        }
        self.colors = colors
    }
}
