//
//  SearchOptionsMenu.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct SearchOptionsMenu: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    var title: String
    var searchOption: SearchOption
    @Binding var isSearchOptionEnabled: (sort: SortOption?, filterOption: FilterOption?)?

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
                            isSearchOptionEnabled = (sort: nil, filterOption: nil)
                            dismiss()

                        }
                        ActionButtonView(title: "Pending") {
                            isSearchOptionEnabled = (sort: nil, filterOption: FilterOption.Pending)
                            dismiss()

                        }
                        ActionButtonView(title: "Completed") {
                            isSearchOptionEnabled = (sort: nil, filterOption: FilterOption.Completed)
                            dismiss()

                        }
                    }
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        ActionButtonView(title: "Priority") {
                            isSearchOptionEnabled = (sort: SortOption.Priority, filterOption: nil)
                            dismiss()

                        }
                        ActionButtonView(title: "Date") {
                            isSearchOptionEnabled = (sort: SortOption.Date, filterOption: nil)
                            dismiss()
                        }
                        ActionButtonView(title: "Alphabetical Order") {
                            isSearchOptionEnabled = (sort: SortOption.Alphabetical, filterOption: nil)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchOptionsMenu(title: "Sort", searchOption: .Sort, isSearchOptionEnabled: .constant(nil)).environmentObject(ThemeManager())
}
