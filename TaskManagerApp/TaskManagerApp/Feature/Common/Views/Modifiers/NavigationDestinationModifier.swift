//
//  NavigationDestinationModifier.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import Foundation
import SwiftUI

struct NavigationDestinationModifier: ViewModifier {
    @ObservedObject var router: NavigationRouter

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                    case .addTask(let action):
                        AddTaskView(action: action, router: router)
                            .toolbar(.hidden, for: .tabBar)

                    case .editAtsk(let action, let taskModel):
                        AddTaskView(action: action, task: taskModel, router: router)
                            .toolbar(.hidden, for: .tabBar)

                }
            }
    }
}
