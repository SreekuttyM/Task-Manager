//
//  TaskListTestcases.swift
//  TaskManagerAppUITests
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import XCTest

final class TaskListTestcases: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting") // Reset Core Data for UI tests
        app.launchArguments.append("--skipOnboarding")
        app.launch()
    }

    func testSwiftUIForOnBaordingView() {
        // Take a screenshot of the entire screen
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways  // Keep in test reports
        add(attachment)
    }
    
    func testListDisplaysItems() throws {
        
        let cells = app.collectionViews.cells
        
        XCTAssertTrue(cells.count == 3)
        
        let firstItem = app.cells.staticTexts["C Task 1"]
        let secondItem = app.staticTexts["A Task 2"]
        
        XCTAssertTrue(firstItem.exists, "Task 1 should be in the list")
        XCTAssertTrue(secondItem.exists, "Task 2 should be in the list")
    }

    func test_searchOptionMenuExists() throws {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        XCTAssertTrue(image.exists, "Image should be visible")
        image.tap()
        let option1 = app.buttons["Sort Sheet Open"]
        let option2 = app.buttons["Filter Sheet Open"]
        XCTAssertTrue(option1.exists, "Sorting should be visible in the menu")
        XCTAssertTrue(option2.exists, "Filter should be visible in the menu")

    }

    func test_selectSortOption() throws {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
                XCTAssertTrue(image.exists, "Image should be visible")
        image.tap()
        let option1 = app.buttons["Sort Sheet Open"]
        let option2 = app.buttons["Filter Sheet Open"]
        XCTAssertTrue(option1.exists, "Sorting should be visible in the menu")
        XCTAssertTrue(option2.exists, "Filter should be visible in the menu")
        option1.firstMatch.tap()

    }

    func testSheetIsPresentedWithSortOptions() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
                XCTAssertTrue(image.exists, "Image should be visible")
        image.tap()
        let option1 = app.buttons["Sort Sheet Open"]
        XCTAssertTrue(option1.exists, "Sorting should be visible in the menu")
        option1.firstMatch.tap()
        let detailView = app.otherElements.staticTexts["Search Option"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 2), "Detail View should be presented")
    }

    func testSheetIsPresentedWithFilterOptions() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
                XCTAssertTrue(image.exists, "Image should be visible")
        image.tap()
        let option2 = app.buttons["Filter Sheet Open"]
        XCTAssertTrue(option2.exists, "Filter should be visible in the menu")
        option2.firstMatch.tap()
        let detailView = app.otherElements.staticTexts["Search Option"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 2), "Detail View should be presented")

    }

    func testSearchListWithsortWithPriority() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        image.tap()
        let option2 = app.buttons["Sort Sheet Open"]
        option2.firstMatch.tap()
        let firstItemBeforeSort = app.staticTexts.element(boundBy: 0).label
        let secondViewButton = app.buttons["Priority"]
        secondViewButton.tap()
        let firstItemAfterSort = app.staticTexts.element(boundBy: 0).label
        XCTAssertNotEqual(firstItemBeforeSort, firstItemAfterSort, "Sorting should change the list order")
    }
    
    func testSearchListWithsortWithDate() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        image.tap()
        let option2 = app.buttons["Sort Sheet Open"]
        option2.firstMatch.tap()
        let firstItemBeforeSort = app.staticTexts.element(boundBy: 0).label
        let secondViewButton = app.buttons["Date"]
        secondViewButton.tap()
        let firstItemAfterSort = app.staticTexts.element(boundBy: 0).label
        XCTAssertNotEqual(firstItemBeforeSort, firstItemAfterSort, "Sorting should change the list order")
    }
    
    func testSearchListWithsortWithAlphabetically() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        image.tap()
        let option2 = app.buttons["Sort Sheet Open"]
        option2.firstMatch.tap()
        let firstItemBeforeSort = app.staticTexts.element(boundBy: 0).label
        let secondViewButton = app.buttons["Alphabetical"]
        secondViewButton.tap()
        let firstItemAfterSort = app.staticTexts.element(boundBy: 0).label
        XCTAssertNotEqual(firstItemBeforeSort, firstItemAfterSort, "Sorting should change the list order")
    }


    func testSearchListWithFilterWithComplete() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        image.tap()
        let option2 = app.buttons["Filter Sheet Open"]
        option2.firstMatch.tap()
        let firstItemBeforeSort = app.staticTexts.element(boundBy: 0).label
        let secondViewButton = app.buttons["Completed"]
        secondViewButton.tap()
        let firstItemAfterSort = app.staticTexts.element(boundBy: 0).label
        XCTAssertNotEqual(firstItemBeforeSort, firstItemAfterSort, "Sorting should change the list order")
    }
    
    func testSearchListWithFilterWithPending() {
        let toolbarMenuButton = app.buttons["Tool Bar Menu"]
        XCTAssertTrue(toolbarMenuButton.exists, "Toolbar menu button should be visible")
        let image = app.navigationBars.images["Image"]
        image.tap()
        let option2 = app.buttons["Filter Sheet Open"]
        option2.firstMatch.tap()
        let firstItemBeforeSort = app.staticTexts.element(boundBy: 0).label
        let secondViewButton = app.buttons["Pending"]
        secondViewButton.tap()
        let firstItemAfterSort = app.staticTexts.element(boundBy: 0).label
        XCTAssertNotEqual(firstItemBeforeSort, firstItemAfterSort, "Sorting should change the list order")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
