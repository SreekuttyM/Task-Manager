//
//  OnboardingView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var root: TAppState
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        ZStack {
            GradientBackgroundView(colors: [theme.selectedTheme.accentColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor, theme.selectedTheme.primaryThemeColor])
            VStack {
                topLogo
                    .padding(.top, 70)
                Spacer()
                header
                    .padding(.bottom, 30)
                bottomButton
                    .padding(.bottom, 40)
            }
        }
    }

    private var topLogo: some View {
        Image(TImage.appLogo.rawValue)

    }

    private var header: some View {
        VStack {
            Text("Taskify").font(theme.selectedTheme.largeTitleFont)
                .foregroundStyle(theme.selectedTheme.accentColor)
            Text("Organize Your Tasks and Goals")
                .font(theme.selectedTheme.textTitleFont)
                .foregroundStyle(theme.selectedTheme.accentColor)
        }
    }

    private var bottomButton: some View {
        Button {
            // action
            root.updateViewState(showHome: true)
        } label: {
            Text("GET STARTED >>").navigationActionModifier(color: theme.selectedTheme.accentColor)
        }
    }
}

#Preview {
    OnboardingView().environmentObject(ThemeManager())
}
