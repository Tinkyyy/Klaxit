//
//  KlaxitUITests.swift
//  KlaxitUITests
//
//  Created by Sabri Belguerma on 07/01/2023.
//

import XCTest

final class KlaxitUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func searchForStreet() throws {
        let app = XCUIApplication()
        app.launch()

        let timeout = 2

        let addAddressButton = app.buttons["addAddressButton"]
        let askAndLocalizationButton = app.buttons["askAndLocalizationButton"]

        let addAddressInputField = app.textFields["addAddressInputField"]

        XCTAssertTrue(addAddressButton.waitForExistence(timeout: TimeInterval(timeout)))
        XCTAssertTrue(askAndLocalizationButton.waitForExistence(timeout: TimeInterval(timeout)))
        
        addAddressButton.tap()
        
        addAddressInputField.tap()
        addAddressInputField.typeText("8 Rue Sainte-Foy")
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
