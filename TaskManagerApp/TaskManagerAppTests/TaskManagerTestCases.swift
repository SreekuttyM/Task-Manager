//
//  TaskManagerTestCases.swift
//  TaskManagerAppTests
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import XCTest
@testable import TaskManagerApp

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
        sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
//        var results: [TaskModel] = []
//        _ = Task {
//            results = try await sut.fetchTaskList()
//        }

        let results = try await sut.fetchTaskList()

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.last?.taskTitle, "Title 1")
        XCTAssertEqual(results.last?.taskDescription, "Title 2")
        XCTAssertEqual(results.last?.taskPriority, .Low)

    }

    func test_insertingTwoItemsReceiveTwoItems() async throws {
        sut.createTaskItem(taskId: UUID(), title: "Title 1", description: "Title 2", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        sut.createTaskItem(taskId: UUID(), title: "Title 2", description: "Title 3", date: Date.now, prority: TaskPriority.Low.rawValue, taskProgress: 0.5)
        let results = try await sut.fetchTaskList()

        XCTAssertEqual(results.count, 2)

    }

}
