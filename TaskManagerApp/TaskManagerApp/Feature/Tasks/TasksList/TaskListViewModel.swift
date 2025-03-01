//
//  TaskListViewModel.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation
import Combine

enum ViewState {
    case isLoading
    case failed(error: Error)
    case finish(taksList: [TaskModel])
}

public enum SearchOption: String, CaseIterable {
    case Sort = "Sort"
    case Filter = "Filter"
    case ShowCompleted = "Show Completed"
    case None
}

public enum SortOption: String, CaseIterable {
    case Priority = "Priority"
    case Date = "Date"
    case Alphabetical = "Alphabetical"

    var descriptor: NSSortDescriptor {
        switch self {
            case .Priority:
                return NSSortDescriptor(key: "taskPriority", ascending: false)
            case .Date:
                return NSSortDescriptor(key: "taskCreationDate", ascending: false)
            case .Alphabetical:
                return NSSortDescriptor(key: "taskTitle", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))

        }
    }
}

public enum FilterOption: String, CaseIterable {
    case All = "All"
    case Pending = "Pending"
    case Completed = "Completed"
    var predicate: NSPredicate? {
        switch self {
            case .All:
                return nil
            case .Pending:
                return  NSPredicate(format: "isComplete == false")
            case .Completed:
                return NSPredicate(format: "isComplete == true")
        }
    }
}

class TaskListViewModel: ObservableObject {
    @Published  var isAnimated: Bool = false
    @Published  var selectedSearchOption: SearchOption = .None
    @Published  var viewState: ViewState = .isLoading
    @Published  var isPresented: Bool = false

    @Published var array_tasks: [TaskModel] = []
    @Published var isSearchOptionEnabled: (sort: SortOption?, filterOption: FilterOption?)?

    var taskManager: TaskManager!
    private var cancellables = Set<AnyCancellable>()

    init(taskManager: TaskManager = TaskManager(coreDataManager: CoreDataManager())) {
        $isSearchOptionEnabled
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { option in
                if let option = option {
                    self.fetchTasks(filter: option.filterOption, sort: option.sort)
                }
            }
            .store(in: &cancellables)
        self.taskManager = taskManager
    }

    func fetchTasks(filter: FilterOption? = nil, sort: SortOption? = nil) {
        Task {
            do {
                let fetchTasks = try await taskManager.fetchTaskList(filterOption: filter, sortOption: sort)
                await MainActor.run {
                    self.array_tasks = fetchTasks
                    viewState = .finish(taksList: fetchTasks)
                }
            } catch {
                await MainActor.run {
                    viewState = .failed(error: error)
                    print(error)
                }
            }
        }
    }

    func deleteTaskModel(selectedTask: TaskModel) {
        viewState = .isLoading
        Task {
            do {
                try await  taskManager.deleteSingleTask(taskId: selectedTask.taskId)
                await MainActor.run {
                    array_tasks.removeAll { $0 == selectedTask }
                    viewState = .finish(taksList: array_tasks)
                }
            } catch {
                await MainActor.run {
                    viewState = .failed(error: error)
                    print("failed")
                }
            }
        }
    }

    func markTaskToComplete(selectedTask: TaskModel) {
        viewState = .isLoading
        Task {
            do {
                try await taskManager.markAsComplete(taskId: selectedTask.taskId, isCompleted: true, taskProgress: 1.0)
                await MainActor.run {
                    let task = array_tasks.filter { $0 == selectedTask }.first
                    if var task = task {
                        task.isCompleted = true
                        task.taskProgress = 1.0
                        if let row = array_tasks.firstIndex(where: {$0.taskId == task.taskId}) {
                            array_tasks.remove(at: row)
                            array_tasks.insert(task, at: row
                            )
                        }
                    }
                    viewState = .finish(taksList: array_tasks)
                }
            } catch {
                await MainActor.run {
                    viewState = .failed(error: error)
                    print("failed")
                }
            }
        }
    }

}
