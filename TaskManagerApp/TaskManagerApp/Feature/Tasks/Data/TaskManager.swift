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

    func fetchTaskList(filterOption: FilterOption? = nil, sortOption: SortOption? = nil) async throws -> [TaskModel] {
        let request = TaskItem.createFetchRequest()
        let context = coreDataManager.context
        if let predicate = filterOption?.predicate {
            request.predicate = predicate
        }
        if let sortDescriptor = sortOption?.descriptor {
            request.sortDescriptors = [sortDescriptor]
        }
        request.returnsObjectsAsFaults = false
        do {
            let tasks =  try context.fetch(request)
            var taskModels: [TaskModel] = []
            for task in tasks {
                taskModels.append(TaskModel(taskId: task.taskId, taskCreationDate: task.taskCreationDate, taskDescription: task.taskDescription, taskPriority: TaskPriority(rawValue: Int(task.taskPriority)) ?? .Low, taskTitle: task.taskTitle, isCompleted: task.isComplete))
            }
            return taskModels

        } catch {
            print("Failed to fetch data: \(error)")
        }

        return []
    }

    func createTaskItem(taskId: UUID = UUID(), title: String, description: String, date: Date, prority: Int, isComplete: Bool = false) {
        let taskItem = TaskItem(context: coreDataManager.context)
        taskItem.taskId = taskId
        taskItem.taskTitle = title
        taskItem.taskDescription = description
        taskItem.taskCreationDate = date
        taskItem.taskPriority = Int32(prority)
        taskItem.isComplete = isComplete
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

    func markAsComplete(taskId: UUID, isCompleted: Bool) {
        let request = TaskItem.createFetchRequest()
        request.predicate = NSPredicate(format: "taskId == %@", taskId as CVarArg)
        if let fetchedTask = try? coreDataManager.context.fetch(request).first {
            fetchedTask.isComplete = isCompleted
        }
        if coreDataManager.context.hasChanges {
            do {
                try coreDataManager.context.save()
                print("Updated")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func deleteSingleTask(taskId: UUID) {
        let request = TaskItem.createFetchRequest()
        request.predicate = NSPredicate(format: "taskId == %@", taskId as CVarArg)
        if let fetchedTask = try? coreDataManager.context.fetch(request).first {
            coreDataManager.context.delete(fetchedTask)
        }
        if coreDataManager.context.hasChanges {
            do {
                try coreDataManager.context.save()
                print("deleted")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
