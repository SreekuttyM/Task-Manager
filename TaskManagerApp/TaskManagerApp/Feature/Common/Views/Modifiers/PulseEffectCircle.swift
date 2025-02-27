//
//  PulseEffectCircle.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct PulseEffectCircle: View {
    @Binding var isOn: Bool
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Image(systemName: "plus")
            .font(theme.selectedTheme.largeTitleFont)
            .padding()
            .background(theme.selectedTheme.accentColor)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(theme.selectedTheme.primaryThemeColor, lineWidth: 1)
                    .scaleEffect(isOn ? 2 : 1)
                    .opacity(isOn ? 0 : 1)
                    .animation(isOn ? Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: isOn) : Animation.easeInOut(duration: 1.0), value: isOn)
            }
    }
}
