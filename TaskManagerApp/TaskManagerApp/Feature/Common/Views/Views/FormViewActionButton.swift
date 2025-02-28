//
//  FormViewActionButton.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct FormViewActionButton: View {
    var action: () -> Void
    var title: String
    var body: some View {
        Button(title, action: action)
    }
}

#Preview {
    FormViewActionButton(action: {
    }, title: "Submit")
}
