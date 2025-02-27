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

    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)

        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]

        return self
    }

}
