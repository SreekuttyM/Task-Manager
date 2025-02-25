//
//  TAppView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TAppView: View {
    @StateObject var appState: TAppState = TAppState()
    var body: some View {
        AppViewBuilder(
            showHome: appState.showHome,
            homeView: {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }, onBoardingView: {
                OnboardingView()
            }
        ).environmentObject(appState)
    }
}

#Preview {
    TAppView(appState: TAppState(showHome: true))
}

#Preview {
    TAppView(appState: TAppState(showHome: false))
}
