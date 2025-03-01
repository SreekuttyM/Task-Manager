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
    @Binding var isSearchOptionEnabled: (sort: SortOption?, filterOption: FilterOption?)?
    var title: String
    var searchOption: SearchOption

    var body: some View {
        VStack {
            HeaderView
            ScrollView(.vertical, showsIndicators: false) {
                if searchOption == .Filter {
                    FilterOptionList
                } else {
                    SortOptionList
                }
            }
        }
    }

    private var HeaderView: some View {
        VStack {
            Text(title)
                .headerTextHeading(theme: theme)
                .padding(.top, 20)
                .padding(.bottom, 5)
                .accessible(.text(label: "Search Option"))
            Text("\(title.capitalized) Tasks By")
                .secondaryTextHeading(theme: theme)
                .accessible(.text(label: "Tasks By"))

        }
    }

    private var SortOptionList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(SortOption.allCases, id: \.self) { filterOption in
                FormViewActionButton(action: {
                    isSearchOptionEnabled = (sort: filterOption, filterOption: nil)
                    dismiss()
                }, title: filterOption.rawValue
                ).padding()
            }
        }
    }

    private var FilterOptionList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(FilterOption.allCases, id: \.self) { filterOption in
                FormViewActionButton(action: {
                    isSearchOptionEnabled = (sort: nil, filterOption: filterOption)
                    dismiss()
                }, title: filterOption.rawValue
                ).padding()
            }
        }

    }
}

#Preview {
    SearchOptionsMenu(isSearchOptionEnabled: .constant(nil), title: "Sort", searchOption: .Sort).environmentObject(ThemeManager())
}
