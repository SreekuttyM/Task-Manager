//
//  TaskListViewModel.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation
public enum SearchOption: String, CaseIterable {
    case Sort = "Sort"
    case Filter = "Filter"
    case ShowCompleted = "Show Completed"
    case None
}

class TaskListViewModel: ObservableObject {
    @Published  var isAnimated: Bool = false
    @Published  var selectedSearchOption: SearchOption = .None
    @Published  var isPresented: Bool = false
    @Published  var array_tasks: [TaskModel] = []

    var taskManager: TaskManager = TaskManager(coreDataManager: CoreDataManager())

    func fetchTasks() async {
        do {
            let fetchTasks = try await taskManager.fetchTaskList()
            await MainActor.run {
                self.array_tasks = fetchTasks
            }
        } catch {
            print(error)
        }
    }

}
