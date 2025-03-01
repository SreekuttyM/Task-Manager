//
//  CoreDataManager.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    public init() {}
    public static let modelName = "Tasks"

    public static let model: NSManagedObjectModel = {
        // swiftlint:disable force_unwrapping
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.modelName, managedObjectModel: CoreDataManager.model)
        container.persistentStoreDescriptions.forEach { storeDesc in
            storeDesc.shouldMigrateStoreAutomatically = true
            storeDesc.shouldInferMappingModelAutomatically = true
        }
        container.loadPersistentStores { _, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = self.context
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func clearData() {
        let deleteRequest = TaskItem.createFetchRequest()
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print(error)
        }
    }

    /// Injects dummy test data for UI tests
    func seedTestData() {
        let tasks = [TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "C Task 1", taskProgress: 1, isCompleted: true),
                     TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "A Task 2", taskProgress: 0.5, isCompleted: false),
                     TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "B Task 3", taskProgress: 0.5, isCompleted: false)]
        for task in tasks {
            let taskItem = TaskItem(context: context)
            taskItem.taskId = task.taskId
            taskItem.taskTitle = task.taskTitle
            taskItem.taskDescription = task.taskDescription
            taskItem.taskCreationDate = task.taskCreationDate
            taskItem.taskPriority = Int32(task.taskPriority.rawValue)
            taskItem.taskProgress = task.taskProgress
            taskItem.isComplete = task.isCompleted

        }

        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

    }
}
