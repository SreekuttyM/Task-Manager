//
//  AppViewBuilder.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct AppViewBuilder<HomeView: View, OnboardingView: View>: View {
    var showHome: Bool
    @ViewBuilder var homeView: HomeView
    @ViewBuilder var onBoardingView: OnboardingView

    var body: some View {
        ZStack {
            if showHome {
                homeView
            } else {
                onBoardingView
            }
        }
    }
}

#Preview {
    AppViewBuilder(showHome: true, homeView: {
        Text("Home Screen")
    }, onBoardingView: {
        OnboardingView()
    })
}
