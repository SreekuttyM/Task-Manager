//
//  SearchOptionsMenu.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct SearchOptionsMenu: View {
    @EnvironmentObject var theme: ThemeManager
    var title: String
    var searchOption: SearchOption

    @State var optionList: [String] = []
    var body: some View {
        VStack {
            Text(title)
                .font(theme.selectedTheme.textTitleFont)
                .foregroundStyle(theme.selectedTheme.accentColor)
                .padding(.top, 20)
                .padding(.bottom, 5)
            Text("Order Tasks By")
                .font(theme.selectedTheme.subTextFont)
                .foregroundStyle(theme.selectedTheme.accentColor)
            ScrollView(.vertical, showsIndicators: false) {
                if searchOption == .Filter {
                    VStack(alignment: .center, spacing: 0) {
                        ActionButtonView(title: "All") {

                        }
                        ActionButtonView(title: "Pending") {

                        }
                        ActionButtonView(title: "Completed") {
                        }
                    }
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        ActionButtonView(title: "Priority") {

                        }
                        ActionButtonView(title: "Date") {

                        }
                        ActionButtonView(title: "Alphabetical Order") {
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchOptionsMenu(title: "Sort", searchOption: .Sort).environmentObject(ThemeManager())
}
