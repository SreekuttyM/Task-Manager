//
//  TaskManagerTestCases.swift
//  TaskManagerAppTests
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import XCTest
@testable import TaskManagerApp

class TaskManagerMock: TaskManager {
    override func fetchTaskList(filterOption: FilterOption? = nil, sortOption: SortOption? = nil) async throws -> [TaskModel] {
        throw NSError(domain: "CoreDataError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Fetch failed"])

    }
}

final class TaskManagerTestCases: XCTestCase {

    var sut: TaskManager!

       override func setUp() {
           super.setUp()
           let coreDataStack = CoreDataTestManager()
           sut = TaskManager(coreDataManager: coreDataStack)
       }

       override func tearDown() {
           sut = nil
           super.tearDown()
       }

    func test_initSetUp() async {
        var results: [TaskModel] = []
        _ = Task {
            results = try await sut.fetchTaskList()
        }

        XCTAssertEqual(results.count, 0)
    }

    func test_insertOneItemReceiveOneItem() async throws {
        try await sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList()
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.last?.taskTitle, "Title 1")
        XCTAssertEqual(results.last?.taskDescription, "Title 2")
        XCTAssertEqual(results.last?.taskPriority, .Low)

    }

    func test_insertingTwoItemsReceiveTwoItems() async throws {
        try await sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Title 2", description: "Title 3", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList()
        XCTAssertEqual(results.count, 2)
    }

    func test_deleteSingleItem() async throws {
        try await sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Title 2", description: "Title 3", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList()
        if let result = results.first {
            try await sut.deleteSingleTask(taskId: result.taskId)
            let results = try await sut.fetchTaskList()
            XCTAssertEqual(results.count, 1)

        }
    }

    func test_fetchTasksWithSortOptionWithDate() async throws {
        let today = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        try await sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: today, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Titlqwwrwr", description: "Title 3", date: tomorrow, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList()

        if let first = results.first, let last = results.last {
            XCTAssertEqual(first.taskCreationDate > last.taskCreationDate, true)
        } else {
            XCTFail("Failed as the results is not saved properly")
        }
    }

    func test_fetchTasksWithSortOptionAlphabetical() async throws {
        let today = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        try await sut.createTaskItem(taskId: UUID(), title: "Refactor", description: "Title 2", date: today, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task", description: "Title 3", date: tomorrow, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList(sortOption: .Alphabetical)
        XCTAssertEqual(results.first?.taskTitle, "Daily Task")
    }

    func test_fetchTasksWithSortOptionPriority() async throws {
        let today = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        try await sut.createTaskItem(taskId: UUID(), title: "Refactor", description: "Title 2", date: today, prority: TaskPriority.Medium.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 1", description: "Title 3", date: tomorrow, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 2", description: "Title 3", date: tomorrow, prority: TaskPriority.High.rawValue, taskProgress: 0.5)

        let results = try await sut.fetchTaskList(sortOption: .Priority)
        XCTAssertEqual(results.first?.taskTitle, "Daily Task 2")
    }

    func test_fetchTasksWithFilterOptionPending() async throws {
        let today = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        try await sut.createTaskItem(taskId: UUID(), title: "Refactor", description: "Title 2", date: today, prority: TaskPriority.Medium.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 1", description: "Title 3", date: tomorrow, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 2", description: "Title 3", date: tomorrow, prority: TaskPriority.High.rawValue, isComplete: true, taskProgress: 1)

        let results = try await sut.fetchTaskList(filterOption: .Pending)
        XCTAssertEqual(results.count, 2)
    }

    func test_fetchTasksWithFilterOptionCompleted() async throws {
        let today = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        try await sut.createTaskItem(taskId: UUID(), title: "Refactor", description: "Title 2", date: today, prority: TaskPriority.Medium.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 1", description: "Title 3", date: tomorrow, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        try await  sut.createTaskItem(taskId: UUID(), title: "Daily Task 2", description: "Title 3", date: tomorrow, prority: TaskPriority.High.rawValue, isComplete: true, taskProgress: 1)

        let results = try await sut.fetchTaskList(filterOption: .Completed)
        XCTAssertEqual(results.count, 1)
    }

}
