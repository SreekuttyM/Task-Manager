//
//  GradientBackGroundView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct GradientBackgroundView: View {
    var colors: [Color]
    init(colors: [Color] = [TColor.accent, TColor.primary, TColor.primary, TColor.primary]) {
        self.colors = colors
    }
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}
