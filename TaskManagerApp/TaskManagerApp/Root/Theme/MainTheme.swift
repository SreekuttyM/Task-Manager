//
//  MainTheme.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import SwiftUI

enum ThemeName: String, CaseIterable {
    case main = "Main"
    case red = "Red"
    case blue = "Blue"
    case green = "Green"
    case cyan = "Cyan"
    case mint = "Mint"
    case indigo = "Indigo"
    case teal = "Teal"
    case purple = "Purple"
    case orange = "Orange"

}

struct MainTheme: ThemeProtocol {

    private var folder: String

    init(folder: String) {
        self.folder = folder
    }

    var accentColor: Color {
        Color("AccentColor_\(folder)", bundle: Bundle(path: "Color"))
    }
    var primaryThemeColor: Color { Color("TPrimaryColor_\(folder)", bundle: Bundle(path: "Color")) }
    var secondoryThemeColor: Color { Color("TSecondaryColor_\(folder)", bundle: Bundle(path: "Color")) }

    var largeTitleFont: Font = .customFont(fontType: .black, size: 30)
    var textTitleFont: Font = .customFont(fontType: .bold, size: 20)
    var subTextFont: Font = .customFont(fontType: .light, size: 15)
    var secondaryTextTitleFont: Font = .customFont(fontType: .medium, size: 15)

}
