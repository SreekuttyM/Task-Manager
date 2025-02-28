//
//  TaskItem+CoreDataProperties.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//
//

import Foundation
import CoreData

extension TaskItem {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var taskCreationDate: Date
    @NSManaged public var taskDescription: String
    @NSManaged public var taskPriority: Int32
    @NSManaged public var taskTitle: String
    @NSManaged public var isComplete: Bool
    @NSManaged public var taskId: UUID
    @NSManaged public var taskProgress: Double

}

extension TaskItem: Identifiable {

}
