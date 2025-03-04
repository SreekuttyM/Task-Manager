//
//  TaskManagerAppUITests.swift
//  TaskManagerAppUITests
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import XCTest
@testable import TaskManagerApp
final class TaskManagerAppUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--resetOnboarding")
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    func testSwiftUIForOnBaordingView() {
        // Take a screenshot of the entire screen
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways  // Keep in test reports
        add(attachment)
    }

    func testOnboardingFlow() {
        let getStartedButton = app.buttons["Button"]
        XCTAssertTrue(getStartedButton.exists, "Onboarding should be visible on first launch")
        getStartedButton.tap()
        let homeTab = app.buttons["homeTab"]
        XCTAssertTrue(homeTab.waitForExistence(timeout: 2), "Main Tab View should appear after onboarding")
    }

    func test_buttonActionOpensTabScreen() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Button"].tap()
        let navBar = app.navigationBars.staticTexts["TASKIFY"]
        XCTAssertTrue(navBar.exists)
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    func scrollToElement(in app: XCUIApplication) {
        while !self.isHittable {
            app.swipeUp()
        }
    }
}
