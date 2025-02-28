//
//  EmptyView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct EmptyView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .padding()
                .background(theme.selectedTheme.accentColor)
                .clipShape(Circle())
                .accessible(.image)
            Text("You have no lists 🥲")
                .primaryTextHeading(theme: theme)
                .padding(.bottom, 2)
                .accessible(.text)
            Text("Press the + button to create one")
                .secondaryTextHeading(theme: theme)
                .accessible(.text)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyView().environmentObject(ThemeManager())
}
