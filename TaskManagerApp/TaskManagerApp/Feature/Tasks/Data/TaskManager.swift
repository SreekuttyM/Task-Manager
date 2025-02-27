//
//  TaskManager.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation

class TaskManager {
    let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
          self.coreDataManager = coreDataManager
    }

    func fetchTaskList() async throws -> [TaskModel] {
        let request = TaskItem.createFetchRequest()
        let context = coreDataManager.context
        request.returnsObjectsAsFaults = false
        do {
            let tasks =  try context.fetch(request)
            var taskModels: [TaskModel] = []
            for task in tasks {
                taskModels.append(TaskModel(taskCreationDate: task.taskCreationDate, taskDescription: task.taskDescription, taskPriority: TaskPriority(rawValue: Int(task.taskPriority)) ?? .Low, taskTitle: task.taskTitle))
            }
            return taskModels

        } catch {
            print("Failed to fetch data: \(error)")
        }

        return []
    }

    func createTaskItem(title: String, description: String, date: Date, prority: Int) {
        let todo = TaskItem(context: coreDataManager.context)
        todo.taskTitle = title
        todo.taskDescription = description
        todo.taskCreationDate = date
        todo.taskPriority = Int32(prority)
        if coreDataManager.context.hasChanges {
            do {
                try coreDataManager.context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
