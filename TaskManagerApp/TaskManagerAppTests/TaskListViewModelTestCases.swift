//
//  TaskListViewModel.swift
//  TaskManagerAppTests
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import XCTest
@testable import TaskManagerApp

class MockTaskListViewModel: TaskListViewModel {
    var results: [TaskModel] = []
    override func fetchTasks(filter: FilterOption? = nil, sort: SortOption? = nil) {
        Task {
            do {
                results = try await getMockData()
            } catch {
                throw NSError(domain: "CoreDataError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Fetch failed"])
            }
        }
    }

    override func deleteTaskModel(selectedTask: TaskModel) {
        results.removeAll { $0 == selectedTask }
    }

    override func markTaskToComplete(selectedTask: TaskModel) {
        var selectedTask = selectedTask
        if let row = results.firstIndex(where: {$0.taskId == selectedTask.taskId}) {
            selectedTask.isCompleted = true
            results[row] = selectedTask
        }
    }

    func getMockData()  async throws -> [TaskModel] {
        return [TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "Task 1", taskProgress: 0.5, isCompleted: false),
                TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "Task 2", taskProgress: 0.5, isCompleted: false),
                TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "Task 3", taskProgress: 0.5, isCompleted: false)]
    }
}

final class TaskListViewModelTestCases: XCTestCase {

    var sut: MockTaskListViewModel!

    override func setUp() {
        super.setUp()
        sut = MockTaskListViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchTasksWithResults() {
        sut.fetchTasks()
        switch sut.viewState {
            case .isLoading:
                break
            case .failed:
                XCTFail("Expected success but received fail")
            case .finish(taksList: let taksList):
                XCTAssertEqual(taksList.count, 0)
        }
    }

    func test_fetchTasksWithFailure() {
        sut.fetchTasks()
        switch sut.viewState {
            case .isLoading:
                break
            case .failed:
                XCTFail("Expected success but received fail")
            case .finish(taksList: let taksList):
                XCTAssertEqual(taksList.count, 0)
        }
    }

    func test_fetchTasksErorCase() async {
        let sut = MockTaskListViewModel()
        sut.fetchTasks()
        switch sut.viewState {
            case .isLoading:
                break
            case .failed(let error):
                XCTAssertEqual(error.localizedDescription, "Fetch failed")
            case .finish:
                XCTAssertTrue(sut.array_tasks.isEmpty)
        }
    }

    func test_deleteSingleTask() async {
        let sut = MockTaskListViewModel()
        sut.fetchTasks()
        sleep(10)
        sut.deleteTaskModel(selectedTask: sut.results.first!)
        XCTAssertTrue(sut.results.count == 2)
    }

    func test_markAsComplete() async {
        let sut = MockTaskListViewModel()
        sut.fetchTasks()
        sleep(10)
        sut.markTaskToComplete(selectedTask: sut.results.first!)
        XCTAssertTrue(sut.results.first!.isCompleted)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
