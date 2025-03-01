//
//  TaskCreationTests.swift
//  TaskManagerAppUITests
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import XCTest

final class TaskCreationTests: XCTestCase {
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
    
    func test_pulseEffect() throws {
        let button = app.buttons["Pulse Button"]
        XCTAssertTrue(button.exists, "The button should be visible")
        let initialFrame = button.frame
        button.tap()
        sleep(1)
        let finalFrame = button.frame
        XCTAssertNotEqual(initialFrame, finalFrame, "Button should have changed its size due to animation")
    }

    func testNavigationToAddTaskItem() {
        let button = app.buttons["Pulse Button"]
        XCTAssertTrue(button.waitForExistence(timeout: 5), "Slider not found")
        button.tap()
        sleep(1)
        let navBar = app.navigationBars.staticTexts["ADD TASK"]
        XCTAssertTrue(navBar.exists)

    }

    func testTaskCreationForm() throws {
        // Find the UI elements
        let button = app.buttons["Pulse Button"]
        XCTAssertTrue(button.exists, "The button should be visible")
        button.tap()
        sleep(1)
        let titleField = app.textFields["Title"]
        let description = app.textFields["Description"]

        XCTAssertTrue(titleField.exists, "Title field should exist")
        XCTAssertTrue(description.exists, "Description field should exist")

        titleField.tap()
        titleField.typeText("title 1")

        description.tap()
        description.typeText("description 1")
        let navButton = app.navigationBars.buttons["Save"]
        navButton.tap()
        let saveButton = app.buttons["SaveAlert"]
        XCTAssertTrue(navButton.exists, "Save button should exist")
        XCTAssertTrue(saveButton.exists, "SaveAlert button should exist")

        saveButton.tap()
        sleep(1)
        // You can add additional assertions, e.g., checking for success messages.
    }
    
    func testSliderAnimation() {
        let button = app.buttons["Pulse Button"]
        XCTAssertTrue(button.exists, "The button should be visible")
        button.tap()
        sleep(1)
        let slider = app.collectionViews.sliders["Slider"]
        XCTAssertTrue(slider.waitForExistence(timeout: 5), "Slider not found")

        slider.swipeRight()
        slider.swipeRight()
        let valueLabel = app.staticTexts["SliderText"]
        XCTAssertTrue(valueLabel.exists, "Slider value label should exist")
        
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "label != ''"),
            object: valueLabel
        )
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed, "Slider value label did not update")
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
