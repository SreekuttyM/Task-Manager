//
//  View+Modifier.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

extension View {
    func navigationActionModifier() -> some View {
        self.padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.customFont(fontType: .bold, size: 20))
            .foregroundStyle(.white)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()

    }

}
