//
//  TaskListItem.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation

struct TaskModel: Hashable {
    var taskId: UUID
    var taskCreationDate: Date
    var taskDescription: String
    var taskPriority: TaskPriority
    var taskTitle: String
    var isCompleted: Bool

    func getTaskPriorityString() -> String {
        switch self.taskPriority {
            case .High:
                return "High"
            case .Low:
                return "Low"
            case .Medium:
              return "Medium"
        }
    }

}
