//
//  CircleView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 26/02/2025.
//

import SwiftUI

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
    CircleView(color: "000000", themeString: ThemeName.main.rawValue, selectedThemeString: .constant(ThemeName.main.rawValue))
}
