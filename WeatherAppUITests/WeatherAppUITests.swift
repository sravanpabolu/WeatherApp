//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import XCTest
import WeatherApp

class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlert() {
        //Make sure you have "Wangdue Phodrang" in the table
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Wangdue Phodrang"].tap()
        app.alerts["Invalid Location"].scrollViews.otherElements.buttons["OK"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
