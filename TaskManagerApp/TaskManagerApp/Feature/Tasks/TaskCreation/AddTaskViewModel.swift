//
//  AddTaskViewModel.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Combine
import Foundation

enum ViewAction: String {
    case EditTask
    case AddTask
}

enum TaskPriority: Int, CaseIterable {
    case High
    case Low
    case Medium

}

class AddTaskViewModel: ObservableObject {
    var action: ViewAction
    var taskManager: TaskManager = TaskManager(coreDataManager: CoreDataManager())
    @Published  var name = ""
    @Published  var description = ""
    @Published  var taskCreatedDate = Date.now
    @Published  var selectedPriority: TaskPriority = .Low
    @Published var title: String = ""

    private var cancellables = Set<AnyCancellable>()
    var disableForm: Bool {
        name.isEmpty || description.isEmpty
    }

    init(action: ViewAction, task: TaskModel? = nil) {
        self.action = action
        if self.action == .AddTask {
            title = TStrings.NTAddTask
        } else {
            title = TStrings.NTEditTask
        }
    }

    func setUpInitialValue(task: TaskModel) {
        self.name = task.taskTitle
        self.description = task.taskDescription
        self.selectedPriority = task.taskPriority
        self.taskCreatedDate = task.taskCreationDate
    }

    func saveTask() {
        taskManager.createTaskItem(title: name, description: description, date: taskCreatedDate, prority: selectedPriority.rawValue)
    }

}
