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
    var normalBtnTitleFont: Font { get }

    var accentColor: Color { get }
    var primaryThemeColor: Color { get }
    var secondoryThemeColor: Color { get }
}

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeProtocol = MainTheme()

    func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }
}
