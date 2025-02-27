//
//  TaskListItem.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation

struct TaskModel: Hashable {

    let taskCreationDate: Date
    let taskDescription: String
    let taskPriority: TaskPriority
    let taskTitle: String

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
