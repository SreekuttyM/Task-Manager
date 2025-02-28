//
//  TaskListViewModel.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation
import Combine

public enum SearchOption: String, CaseIterable {
    case Sort = "Sort"
    case Filter = "Filter"
    case ShowCompleted = "Show Completed"
    case None
}

public enum SortOption {
    case Priority
    case Date
    case Alphabetical

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
    case Completed = "Competed"
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
    @Published  var isPresented: Bool = false
    @Published  var array_tasks: [TaskModel] = []
    @Published var isSearchOptionEnabled: (sort: SortOption?, filterOption: FilterOption?)?

    var taskManager: TaskManager = TaskManager(coreDataManager: CoreDataManager())
    private var cancellables = Set<AnyCancellable>()

    init() {
        $isSearchOptionEnabled
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { option in
                if let option = option {
                    Task {
                        await self.fetchTasks(filter: option.filterOption, sort: option.sort)
                    }
                }
            }
            .store(in: &cancellables)
    }

    func fetchTasks(filter: FilterOption? = nil, sort: SortOption? = nil) async {
        do {
            let fetchTasks = try await taskManager.fetchTaskList(filterOption: filter, sortOption: sort)
            await MainActor.run {
                self.array_tasks = fetchTasks
            }
        } catch {
            print(error)
        }
    }

}
