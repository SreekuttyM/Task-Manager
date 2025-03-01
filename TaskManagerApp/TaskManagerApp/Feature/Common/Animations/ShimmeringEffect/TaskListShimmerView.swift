//
//  TaskListShimmerView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct TaskListShimmerView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        VStack {
            ShimmerEffectView()
                 .cornerRadius(5)
                 .frame(height: 150)
                 .padding(.all, 20)
        }
    }
}

#Preview {
    TaskListShimmerView().environmentObject(ThemeManager())
}
