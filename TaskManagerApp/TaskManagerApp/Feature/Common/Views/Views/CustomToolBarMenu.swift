//
//  CustomToolBarMenu.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct CustomToolBarMenu: View {
    @Binding var isPresented: Bool
    var searchOption: (_ searchOption: SearchOption) -> Void

    var body: some View {
        Menu(content: {
            Button("Sorting", action: {
                isPresented = true
                searchOption(.Sort)
            })
            .accessible(.button)

            Button("Filter", action: {
                isPresented = true
                searchOption(.Filter)
            })
            .accessible(.button)

        }) {
            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                .font(.system(size: 21))
                .accessible(.image)
        }
    }
}

#Preview {
    CustomToolBarMenu(isPresented: .constant(false), searchOption: { _ in

    })
}
