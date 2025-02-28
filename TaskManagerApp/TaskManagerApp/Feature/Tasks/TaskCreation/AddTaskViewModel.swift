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
    @Published  var taskId: UUID
    @Published  var name: String
    @Published  var description: String
    @Published  var taskCreatedDate: Date
    @Published  var selectedPriority: TaskPriority
    @Published  var taskProgress: CGFloat
    @Published  var isCompleted: Bool

    @Published var title: String = ""
    var taskModel: TaskModel?  // If nil, it's an "Add" operation

    private var cancellables = Set<AnyCancellable>()
    var disableForm: Bool {
        name.isEmpty || description.isEmpty
    }

    init(action: ViewAction, taskModel: TaskModel? = nil) {
        self.taskModel = taskModel
        self.taskId = taskModel?.taskId ?? UUID()
        self.name = taskModel?.taskTitle ?? ""
        self.description = taskModel?.taskDescription ?? ""
        self.taskCreatedDate = taskModel?.taskCreationDate ?? Date.now
        self.selectedPriority = taskModel?.taskPriority ?? .Low
        self.taskProgress = Double(taskModel?.taskProgress ?? 0)
        self.isCompleted = taskModel?.isCompleted ?? false

        self.action = action
        switch action {
            case .AddTask:
                self.title = TStrings.NTAddTask
            case .EditTask:
                self.title = TStrings.NTEditTask
        }
    }

    func setUpInitialValue(task: TaskModel) {
        self.name = task.taskTitle
        self.description = task.taskDescription
        self.selectedPriority = task.taskPriority
        self.taskCreatedDate = task.taskCreationDate
    }

    func update() {
        if action == .EditTask {
            taskManager.editTask(taskId: taskId, title: name, description: description, date: taskCreatedDate, prority: selectedPriority.rawValue, taskProgress: taskProgress)
        } else {
            taskManager.createTaskItem(title: name, description: description, date: taskCreatedDate, prority: selectedPriority.rawValue, taskProgress: taskProgress)
        }
    }

    func markTaskToComplete() {
        isCompleted.toggle()
        taskManager.markAsComplete(taskId: self.taskId, isCompleted: isCompleted, taskProgress: taskProgress)
    }

    func deleteTaskModel() {
        taskManager.deleteSingleTask(taskId: self.taskId)
    }

    func showFormButtons() -> Bool {
        return action == .EditTask
    }
}
