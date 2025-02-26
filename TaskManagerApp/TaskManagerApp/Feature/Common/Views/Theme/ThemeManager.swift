//
//  ThemeManager.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import SwiftUI

protocol ThemeProtocol {
    var largeTitleFont: Font { get }
    var textTitleFont: Font { get }
    var subTextFont: Font { get }

    var accentColor: Color { get }
    var primaryThemeColor: Color { get }
    var secondoryThemeColor: Color { get }
}

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeProtocol = MainTheme(folder: ThemeName.main.rawValue)

    init() {
        loadTheme()
    }

    func setTheme(_ themeName: String) {
        selectedTheme = MainTheme(folder: themeName)
        UserDefaults.appTheme = themeName
    }

    private func loadTheme() {
        let themeName = UserDefaults.appTheme
        selectedTheme = MainTheme(folder: ThemeName(rawValue: themeName)?.rawValue ?? ThemeName.main.rawValue)
    }

}
