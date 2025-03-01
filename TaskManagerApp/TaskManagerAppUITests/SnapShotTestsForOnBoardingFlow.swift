//
//  SnapShotTestsForOnBoardingFlow.swift
//  TaskManagerAppUITests
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import XCTest

final class SnapShotTestsForOnBoardingFlow: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--resetOnboarding")
        app.launch()
    }
    
    func testSwiftUIForOnBaordingView() {
        // Take a screenshot of the entire screen
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways  // Keep in test reports
        add(attachment)
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
