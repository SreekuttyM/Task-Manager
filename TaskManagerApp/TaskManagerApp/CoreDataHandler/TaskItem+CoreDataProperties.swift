//
//  TaskItem+CoreDataProperties.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
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

}

extension TaskItem: Identifiable {

}
