//
//  TAppView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TAppView: View {
    @State var showHome: Bool = false
    var body: some View {
        AppViewBuilder(showHome: showHome) {
            Text("Home Screen")
        } onBoardingView: {
            OnboardingView()
        }
    }
}

#Preview {
    TAppView(showHome: true)
}

#Preview {
    TAppView(showHome: false)
}
