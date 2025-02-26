//
//  MainTheme.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import SwiftUI

struct MainTheme: ThemeProtocol {
    var largeTitleFont: Font = .customFont(fontType: .bold, size: 40)
    var textTitleFont: Font = .customFont(fontType: .medium, size: 20)
    var normalBtnTitleFont: Font = .customFont(fontType: .regular, size: 15)

    var accentColor: Color { return TColor.accent }
    var primaryThemeColor: Color { return TColor.primary }
    var secondoryThemeColor: Color { return TColor.secondary }
}
