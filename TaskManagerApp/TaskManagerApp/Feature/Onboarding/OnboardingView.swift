//
//  OnboardingView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var root: TAppState
    var body: some View {
        ZStack {
            GradientBackgroundView(colors: [TColor.accent, TColor.accent, TColor.secondary])
            VStack {
                topLogo
                    .padding(.top, 150)
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
            Text("Taskify").font(.customFont(fontType: .black, size: 40))
                .foregroundStyle(TColor.primary)
            Text("Organize Your Tasks and Goals")
                .font(.customFont(fontType: .light, size: 20))
                .foregroundStyle(TColor.primary)
        }
    }

    private var bottomButton: some View {
        Button {
            // action
            root.updateViewState(showHome: true)
        } label: {
            Text("GET STARTED >>").navigationActionModifier()
        }
    }
}

#Preview {
    OnboardingView()
}
