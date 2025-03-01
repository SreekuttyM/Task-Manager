//
//  View+Modifier.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

extension View {
    func navigationActionModifier(color: Color) -> some View {
        self.padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.customFont(fontType: .black, size: 20))
            .kerning(1)
            .foregroundStyle(.white)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()

    }

    func headerTextHeading(theme: ThemeManager) -> some View {
        self
            .font(theme.selectedTheme.largeTitleFont)
            .foregroundColor(theme.selectedTheme.secondoryThemeColor)

    }

    func primaryTextHeading(theme: ThemeManager) -> some View {
        self
            .font(theme.selectedTheme.secondaryTextTitleFont)
            .foregroundColor(theme.selectedTheme.secondoryThemeColor)

    }

    func secondaryTextHeading(theme: ThemeManager) -> some View {
        self
            .font(theme.selectedTheme.subTextFont)
            .foregroundColor(theme.selectedTheme.secondoryThemeColor)

    }

    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)

        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]

        return self
    }

    func navigationModifierWith(color: Color, title: String) -> some View {
        self
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
        .navigationBarTitleTextColor(color)
    }

}
