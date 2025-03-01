//
//  NavigationRouter.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import Foundation
import SwiftUI

enum NavigationRoute: Hashable {
    case addTask(action: ViewAction)
    case editTask(action: ViewAction, viewModel: TaskModel?)
}

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: NavigationRoute) {
        path.append(route)
    }

    func goBack() {
        path.removeLast()
    }

    func reset() {
        path = NavigationPath()
    }
}
