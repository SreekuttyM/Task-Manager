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
    private let coreDataManager: CoreDataManager!

    init(router: NavigationRouter, coreDataManager: CoreDataManager!) {
        self.router = router
        self.coreDataManager = coreDataManager
    }

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                    case .addTask(let action):
                        AddTaskView(router: router, action: action, taskManager: TaskManager(coreDataManager: coreDataManager), taskModel: nil)
                            .toolbar(.hidden, for: .tabBar)

                    case .editTask(let action, let taskModel):
                        AddTaskView(router: router, action: action, taskManager: TaskManager(coreDataManager: coreDataManager), taskModel: taskModel)
                            .toolbar(.hidden, for: .tabBar)
                            .transition(.move(edge: .bottom))
                           

                }
            }
    }
}
