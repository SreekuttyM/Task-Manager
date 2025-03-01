//
//  TabbedFlowtests.swift
//  TaskManagerAppUITests
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import XCTest

final class TabbedFlowtests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
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

    func testTabBarNavigation() {
            let homeTab = app.buttons["homeTab"]
            let settingsTab = app.buttons["settingsTab"]
            let navBar = app.navigationBars.staticTexts["TASKIFY"]
  
            XCTAssertTrue(navBar.exists, "Home Screen should be visible")

        settingsTab.tap()
            XCTAssertTrue(app.staticTexts["SettingsScreen"].exists, "Settings Screen should be visible")

            homeTab.tap()
            XCTAssertTrue(navBar.exists, "Home Screen should be visible again")
        }

   
   

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
